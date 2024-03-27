//
//  FavoriteNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit
import INewsNowCore

final class FavoriteNewsViewController: UIViewController {
    
    //MARK: - Propertys
    
    lazy var viewScreen: FavoriteNewsView = {
        let view = FavoriteNewsView()
        return view
    }()
    
    private var viewModel: FavoriteNewsViewModeling
    private var coreDataService: CoreDataHelperService
    
    //MARK: - Inits

    init(viewModel: FavoriteNewsViewModeling, coreDataService: CoreDataHelperService) {
        self.viewModel = viewModel
        self.coreDataService = coreDataService
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
         coreDataService.getFavoriteNewsDB()
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.favoriteNewsTableView.delegate = self
        viewScreen.favoriteNewsTableView.dataSource = self
    }
}

extension FavoriteNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataService.dbCoreDataFavoriteNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomFavoriteNewsTableViewCell.identifier,
                                                       for: indexPath) as? CustomFavoriteNewsTableViewCell else { return UITableViewCell()}

       
        let newsFavorited = coreDataService.dbCoreDataFavoriteNews[indexPath.row]
        cell.prepareCell(newsFavorited: newsFavorited)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = coreDataService.dbCoreDataFavoriteNews[indexPath.row]
        viewModel.showDetailsScreen(newsObject: object)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if let id = coreDataService.dbCoreDataFavoriteNews[indexPath.row].value(forKey: "id") as? UUID {
                coreDataService.removeFavoritedNewsCoreData(id: id)
            }
            coreDataService.removeFavoritedNews(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
