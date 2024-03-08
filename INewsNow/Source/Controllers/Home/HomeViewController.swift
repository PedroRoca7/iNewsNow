//
//  HomeViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Propertys
    
    lazy var viewScreen: HomeView = {
        let view = HomeView()
        return view
    }()
    
    private var viewModel: HomeViewModeling
    
    //MARK: - Inits
    
    init(viewModel: HomeViewModeling) {
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
        viewModel.loadNewsBrazil()
        setupDelegateAndDataSource()
        setupMenuFloatingButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.tabBarController?.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.black
        self.tabBarController?.navigationItem.title = "Notícias"
    }
    
    private func setupMenuFloatingButton() {
        viewScreen.menuFloatingButton.addItem(title: "Notícias do Mundo", image: UIImage(systemName: "newspaper.fill")?.withRenderingMode(.alwaysTemplate)) { item in
            self.viewModel.showScreenNewsWorld()
        }
        viewScreen.menuFloatingButton.addItem(title: "Previsão do tempo", image: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysTemplate)) { item in
            self.viewModel.showScreenWeather()
        }
    }
    
    private func setupDelegateAndDataSource() {
        viewScreen.newsTableView.delegate = self
        viewScreen.newsTableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsBrazilList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomNewsBrazilTableViewCell.identifier,
                                                       for: indexPath) as? CustomNewsBrazilTableViewCell else { return UITableViewCell()}
       
        cell.delegate = self
        
        if let newsBrazil = viewModel.newsBrazilList?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = newsBrazil.favorite ? UIColor.red : UIColor.gray
            cell.prepareCell(newsBrazil: newsBrazil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = viewModel.newsBrazilList?.results[indexPath.row] else { return }
        viewModel.showScreenDetailsNews(newsObject: object)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.viewScreen.newsTableView.reloadData()
        }
    }
    
    func failure() {
        Alert.showBasicAlert(title: "Erro", message: "Erro ao carregar as notícias.", viewController: self) {}
    }
}

extension HomeViewController: CustomNewsBrazilTableViewCellDelegate {
    func favoriteButtonTapped(cell: UITableViewCell) {
        guard let indexPathTapped = viewScreen.newsTableView.indexPath(for: cell) else { return }
      
        viewModel.setFavoriteNews(index: indexPathTapped.row)
        DispatchQueue.main.async {
            self.viewScreen.newsTableView.reloadRows(at: [indexPathTapped], with: .none)
        }
    }
}
