//
//  FavoriteNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit

final class FavoriteNewsViewController: UIViewController {
    
    //MARK: - Propertys
    
    lazy var viewScreen: FavoriteNewsView = {
        let view = FavoriteNewsView()
        return view
    }()
    
    private var viewModel: FavoriteNewsViewModeling
    
    //MARK: - Inits

    init(viewModel: FavoriteNewsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNewsCoreData()
        setupNavigationBar()
        DispatchQueue.main.async {
            self.viewScreen.favoriteNewsTableView.reloadData()
        }
    }
    
    //MARK: - Methods
    
    private func setupNavigationBar() {
        self.tabBarController?.navigationItem.title = "Notícias Favoritas"
    }
    
    private func loadNewsCoreData() {
        CoreDataHelper.shared.getFavoriteNewsDB()
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.favoriteNewsTableView.delegate = self
        viewScreen.favoriteNewsTableView.dataSource = self
    }
}

extension FavoriteNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataHelper.shared.dbCoreDataFavoriteNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomFavoriteNewsTableViewCell.identifier,
                                                       for: indexPath) as? CustomFavoriteNewsTableViewCell else { return UITableViewCell()}

       
        let newsFavorited = CoreDataHelper.shared.dbCoreDataFavoriteNews[indexPath.row]
        cell.prepareCell(newsFavorited: newsFavorited)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = CoreDataHelper.shared.dbCoreDataFavoriteNews[indexPath.row]
        viewModel.showDetailsScreen(newsObject: object)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if let id = CoreDataHelper.shared.dbCoreDataFavoriteNews[indexPath.row].value(forKey: "id") as? UUID {
                CoreDataHelper.shared.removeFavoritedNewsCoreData(id: id)
            }
            CoreDataHelper.shared.removeFavoritedNews(test: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            
        }
    }
}
