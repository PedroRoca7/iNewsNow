//
//  MenuFilterNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation
import UIKit

final class MenuFilterNewsViewController: UIViewController {
    
    // MARK: - Propertys
    
    lazy private var viewScreen: MenuFilterNewsView = {
        let view = MenuFilterNewsView()
        return view
    }()
    
    private var viewModel: MenuFilterNewsViewModeling
    
    init(viewModel: MenuFilterNewsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewScreen
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        addTargetButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func addTargetButton() {
        viewScreen.newYorkTimesButtonCategory.button.addTarget(self, action: #selector(showNewYorkTimes), for: .touchUpInside)
    }
    
    @objc private func showNewYorkTimes() {
        viewModel.showScreenNewYorkTimesNews()
    }
    
    private func setupNavigationBar() {
        self.tabBarController?.navigationItem.title = "Categorias"
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.menuTableView.dataSource = self
        viewScreen.menuTableView.delegate = self
        viewScreen.scrollView.delegate = self
    }
}
 
extension MenuFilterNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuFilterNewsTableViewCell.identifier, for: indexPath) as? MenuFilterNewsTableViewCell else {
            return UITableViewCell()
        }
    
        let titleCategory = viewModel.categorys[indexPath.row]
        cell.prepareCollectionCell(titleCategory: titleCategory)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let titleCatergory = viewModel.categorys[indexPath.row]
        viewModel.showScreenCategoryNews(titleCategory: titleCatergory)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension MenuFilterNewsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.viewScreen.scrollView {
            viewScreen.menuTableView.isScrollEnabled = (self.viewScreen.scrollView.contentOffset.y >= 200)
        }
        if scrollView == self.viewScreen.menuTableView {
            viewScreen.menuTableView.isScrollEnabled = (self.viewScreen.menuTableView.contentOffset.y > 0)
        }
    }
}
