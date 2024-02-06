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
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomMostPopularPostsTableViewCell.identifier,
                                                 for: indexPath) as? CustomMostPopularPostsTableViewCell
        
        if let mostPopularNews = homeViewModel.mostPopularPostList?.results[indexPath.row] {
            cell?.prepareCell(mostPopularPost: mostPopularNews)
        }
        
        return cell ?? UITableViewCell()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomMainNewsCollectionViewCell.identifier,
                                                      for: indexPath) as? CustomMainNewsCollectionViewCell
        
        if let mainNews = homeViewModel.mainNewsList?.results[indexPath.row] {
            cell?.prepareCollectionCell(mainNews: mainNews)
        }
        
        return cell ?? UICollectionViewCell()
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
