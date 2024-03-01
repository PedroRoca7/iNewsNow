//
//  WorldNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import UIKit

final class WorldNewsViewController: UIViewController {
    
    // MARK: - Propertys
    
    lazy private var viewScreen: WorldNewsView = {
        let view = WorldNewsView()
        return view
    }()
    
    override func loadView() {
        self.view = viewScreen
    }
    
    private var attempt: Int = 0
    private var viewModel: WorldNewsViewModeling
    
    // MARK: - Inits
    
    init(viewModel: WorldNewsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        loadAllNews()
        viewScreen.todayDateLabel.text = getDateNowConvertToString()
    }
    
    private func getDateNowConvertToString() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE MMMM - yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    private func loadAllNews() {
        viewModel.loadMainNews()
        viewModel.loadMostPopularPost()
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.mostPopularPostsTableView.delegate = self
        viewScreen.mostPopularPostsTableView.dataSource = self
        viewScreen.mainNewsCollectionView.delegate = self
        viewScreen.mainNewsCollectionView.dataSource = self
    }
}

extension WorldNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mostPopularPostList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomMostPopularPostsTableViewCell.identifier,
                                                       for: indexPath) as? CustomMostPopularPostsTableViewCell else { return UITableViewCell()}
        cell.delegate = self
       
        if let mostPopularNews = viewModel.mostPopularPostList?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = mostPopularNews.favorite ? UIColor.red : UIColor.lightGray
            cell.prepareCell(mostPopularPost: mostPopularNews)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsObject = viewModel.mostPopularPostList?.results[indexPath.row] else { return }
        viewModel.showScreenDetailsNews(newsObject: newsObject)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension WorldNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.mainNewsList?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomMainNewsCollectionViewCell.identifier,
                                                            for: indexPath) as? CustomMainNewsCollectionViewCell else { return UICollectionViewCell()}
        cell.delegate = self
        
        if let mainNews = viewModel.mainNewsList?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = mainNews.favorite ? UIColor.red : UIColor.white
            cell.prepareCollectionCell(mainNews: mainNews)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let newsObject = viewModel.mainNewsList?.results[indexPath.row] else { return }
        viewModel.showScreenDetailsNews(newsObject: newsObject)
    }
}

extension WorldNewsViewController: WorldNewsViewModelDelegate {
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

extension WorldNewsViewController: CustomMostPopularPostsTableViewCellDelegate {
    func favoriteButtonTapped(cell: UITableViewCell) {
        guard let indexPathTapped = viewScreen.mostPopularPostsTableView.indexPath(for: cell) else { return }
      
        viewModel.setFavoriteNews(index: indexPathTapped.row, typeNews: .mostPopularNews)
        
        viewScreen.mostPopularPostsTableView.reloadRows(at: [indexPathTapped], with: .none)
    }
}

extension WorldNewsViewController: CustomMainNewsCollectionViewCellDelegate {
    func favoriteButtonTapped(cell: UICollectionViewCell) {
        guard let indexPathTapped = viewScreen.mainNewsCollectionView.indexPath(for: cell) else { return }
        
        viewModel.setFavoriteNews(index: indexPathTapped.row, typeNews: .mainNews)
        
        viewScreen.mainNewsCollectionView.reloadItems(at: [indexPathTapped])
    }
}
