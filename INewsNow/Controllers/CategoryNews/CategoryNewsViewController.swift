//
//  CategoryNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit

final class CategoryNewsViewController: UIViewController {
    
    //MARK: - Propertys
    
    lazy var viewScreen: CategoryNewsView = {
        let view = CategoryNewsView()
        return view
    }()
    
    private var viewModel: CategoryNewsViewModeling
    
    //MARK: - Inits
    
    init(viewModel: CategoryNewsViewModeling) {
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
        viewModel.loadNewsCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = viewModel.titleCategory
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.categoryNewsTableView.delegate = self
        viewScreen.categoryNewsTableView.dataSource = self
    }
    
}

extension CategoryNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsCategoryBrazilList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryNewsTableViewCell.identifier,
                                                       for: indexPath) as? CategoryNewsTableViewCell else { return UITableViewCell()}
        
        cell.delegate = self
        
        if let categoryNewsBrazil = viewModel.newsCategoryBrazilList?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = categoryNewsBrazil.favorite ? UIColor.red : UIColor.gray
            cell.prepareCell(categoryNewsBrazil: categoryNewsBrazil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = viewModel.newsCategoryBrazilList?.results[indexPath.row] else { return }
        viewModel.showScreenDetailsNews(newsObject: object)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension CategoryNewsViewController: CategoryNewsViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.viewScreen.categoryNewsTableView.reloadData()
        }
    }
    
    func failure() {
        print("Deu Ruim")
    }
}

extension CategoryNewsViewController: CategoryNewsTableViewCellDelegate {
    func favoriteButtonTapped(cell: UITableViewCell) {
        guard let indexPathTapped = viewScreen.categoryNewsTableView.indexPath(for: cell) else { return }
        
        viewModel.setFavoriteNews(index: indexPathTapped.row)
        DispatchQueue.main.async {
            self.viewScreen.categoryNewsTableView.reloadRows(at: [indexPathTapped], with: .none)
        }
    }
}
