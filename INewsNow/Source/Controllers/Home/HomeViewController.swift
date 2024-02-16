//
//  HomeViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: Propertys
    
    lazy private var viewScreen: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func loadView() {
        self.view = viewScreen
    }
    
    private var attempt: Int = 0
    private var homeViewModel: HomeViewModeling
    
    // MARK: Inits
    
    init(homeViewModel: HomeViewModeling) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        loadAllNews()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Celula da tableView numero \(indexPath.row)")
        guard let urlSite = homeViewModel.mostPopularPostList?.results[indexPath.row].url else { return }
        homeViewModel.showScreenWebViewController(webSiteNews: urlSite)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Celula da collectionView numero \(indexPath.row)")
        guard let urlSite = homeViewModel.mainNewsList?.results[indexPath.row].url else { return }
        homeViewModel.showScreenWebViewController(webSiteNews: urlSite)
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
        if attempt < 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.attempt += 1
                self.loadAllNews()
            }
        } else {
            print("Falha ao carregar as notícias.")
        }
    }
}

extension HomeViewController: CustomMostPopularPostsTableViewCellDelegate {
    func favoriteButtonTapped(cell: UITableViewCell) {
        guard let indexPathTapped = viewScreen.mostPopularPostsTableView.indexPath(for: cell) else { return }
      
        homeViewModel.setFavoriteNews(index: indexPathTapped.row, typeNews: .mostPopularNews)
        
        viewScreen.mostPopularPostsTableView.reloadRows(at: [indexPathTapped], with: .none)
    }
}

extension HomeViewController: CustomMainNewsCollectionViewCellDelegate {
    func favoriteButtonTapped(cell: UICollectionViewCell) {
        guard let indexPathTapped = viewScreen.mainNewsCollectionView.indexPath(for: cell) else { return }
        
        homeViewModel.setFavoriteNews(index: indexPathTapped.row, typeNews: .mainNews)
        
        viewScreen.mainNewsCollectionView.reloadItems(at: [indexPathTapped])
    }
}
