//
//  HomeViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    lazy private var viewScreen: HomeView = {
        let view = HomeView()
        return view
    }()
    
    var homeViewModel = HomeViewModel()

    override func loadView() {
        self.view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        setupSearchController()
        loadAllNews()
        viewScreen.searchButton.addTarget(self, action: #selector(toggleNavigationBarButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func loadAllNews() {
        homeViewModel.loadMainNews()
        homeViewModel.loadMostPopularPost()
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.mostPopularPostsTableView.delegate = self
        viewScreen.mostPopularPostsTableView.dataSource = self
        viewScreen.mainNewsCollectionView.delegate = self
        viewScreen.mainNewsCollectionView.dataSource = self
        viewScreen.searchController.searchBar.delegate = self
        homeViewModel.delegate = self
    }
    
    private func setupSearchController() {
        viewScreen.searchController.searchBar.placeholder = "Search Posts"
        self.navigationItem.searchController = viewScreen.searchController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    @IBAction func toggleNavigationBarButtonTapped(_ sender: UIButton) {
        let isHidden = self.navigationController?.isNavigationBarHidden ?? true
        self.navigationController?.setNavigationBarHidden(!isHidden, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.mostPopularPostList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomMostPopularPostsTableViewCell.identifier,
                                                       for: indexPath) as? CustomMostPopularPostsTableViewCell else { return UITableViewCell()}
        cell.delegate = self
       
        if let mostPopularNews = homeViewModel.mostPopularPostList?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = mostPopularNews.favorite ? UIColor.red : UIColor.lightGray
            cell.prepareCell(mostPopularPost: mostPopularNews)
        }
           
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.mainNewsList?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomMainNewsCollectionViewCell.identifier,
                                                            for: indexPath) as? CustomMainNewsCollectionViewCell else { return UICollectionViewCell()}
        cell.delegate = self
        
        if let mainNews = homeViewModel.mainNewsList?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = mainNews.favorite ? UIColor.red : UIColor.white
            cell.prepareCollectionCell(mainNews: mainNews)
        }
    
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.viewScreen.mainNewsCollectionView.reloadData()
            self.viewScreen.mostPopularPostsTableView.reloadData()
        }
    }
    
    func failure() {
        print("Falhou!")
    }
}

extension HomeViewController: CustomMostPopularPostsTableViewCellDelegate {
    func favoriteButtonTapped(cell: UITableViewCell) {
        guard let indexPathTapped = viewScreen.mostPopularPostsTableView.indexPath(for: cell) else { return }
      
        let contact = homeViewModel.mostPopularPostList?.results[indexPathTapped.row]
       
        let hasFavorited = contact?.favorite
        homeViewModel.setFavoriteNews(index: indexPathTapped.row, typeNews: .mostPopularNews)
        
        viewScreen.mostPopularPostsTableView.reloadRows(at: [indexPathTapped], with: .none)
    }
}

extension HomeViewController: CustomMainNewsCollectionViewCellDelegate {
    func favoriteButtonTapped(cell: UICollectionViewCell) {
        guard let indexPathTapped = viewScreen.mainNewsCollectionView.indexPath(for: cell) else { return }
        
        let contact = homeViewModel.mainNewsList?.results[indexPathTapped.row]
        
        let hasFavorited = contact?.favorite
        homeViewModel.setFavoriteNews(index: indexPathTapped.row, typeNews: .mainNews)
        
        viewScreen.mainNewsCollectionView.reloadItems(at: [indexPathTapped])
    }
}
