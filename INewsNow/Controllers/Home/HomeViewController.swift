//
//  HomeViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

protocol HomeViewControlling: NSObject {
    func didFinishLoading()
    func reloadData(newsBrazil: NewsBrazilModel)
    func didFailNewsFetching()
}

final class HomeViewController: UIViewController {
    
    //MARK: - Propertys
    
    lazy var viewScreen: HomeView = {
        let view = HomeView()
        return view
    }()
                
    private let interactor: HomeInteracting
    private let coordinator: HomeCoordinating
    private let dataSource = HomeTableViewDataSource()
    
    //MARK: - Inits
    
    init(interactor: HomeInteracting, coordinator: HomeCoordinating) {
        self.interactor = interactor
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewScreen
    }
        
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getNewsFromBrazil()
        setupDelegateAndDataSource()
        startLoadingView()
    }
    
  
    private func startLoadingView() {
        viewScreen.loaderView.isHidden = false
        viewScreen.loader.startAnimating()
    }
    
    private func stopLoadingView() {
        DispatchQueue.main.async {
            self.viewScreen.loaderView.isHidden = true
            self.viewScreen.loader.stopAnimating()
        }
        
    }
    
    private func setupNavigationBar() {
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.tabBarController?.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.black
        self.tabBarController?.navigationItem.title = "Notícias"
    }
    
    private func setupDelegateAndDataSource() {
        viewScreen.newsTableView.delegate = dataSource
        viewScreen.newsTableView.dataSource = dataSource
        dataSource.delegate = self
    }
}

extension HomeViewController: CustomNewsBrazilTableViewCellDelegate {
    func favoriteButtonTapped(cell: UITableViewCell) {
        guard let indexPathTapped = viewScreen.newsTableView.indexPath(for: cell) else { return }
      
        interactor.saveObjectInDB(myObjectAtIndex: indexPathTapped.row)
        DispatchQueue.main.async {
            self.viewScreen.newsTableView.reloadRows(at: [indexPathTapped], with: .none)
        }
    }
}

extension HomeViewController: HomeViewControlling {
    func didFinishLoading() {
        stopLoadingView()
    }
    
    func reloadData(newsBrazil: NewsBrazilModel) {
        dataSource.reloadTableView(with: newsBrazil)
        DispatchQueue.main.async {
            self.viewScreen.newsTableView.reloadData()
        }
    }
    
    func didFailNewsFetching() {
        //Show Alert
        print("erro ao carregar as notícias.")
    }
}

extension HomeViewController: HomeTableViewDataSourceDelegate {
    func favoritedButtonClicked(index: Int) {
        interactor.saveObjectInDB(myObjectAtIndex: index)
    }
    
    func cellClicked(newsObject: Article) {
        coordinator.showScreenDetailsNews(newsObject: newsObject)
    }
}
