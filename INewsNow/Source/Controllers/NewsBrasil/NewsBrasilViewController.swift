//
//  NewsBrasilViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class NewsBrasilViewController: UIViewController {
    
    //MARK: Propertys
    
    lazy var viewScreen: NewsBrasilView = {
        let view = NewsBrasilView()
        return view
    }()
    
    private var viewModel: NewsBrazilViewModeling
    
    //MARK: Inits
    
    init(viewModel: NewsBrazilViewModeling) {
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
    }
    
    private func setupDelegateAndDataSource() {
        viewScreen.newsTableView.delegate = self
        viewScreen.newsTableView.dataSource = self
        viewModel.delegate = self
    }
}

extension NewsBrasilViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsBrazilList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomNewsBrasilTableViewCell.identifier,
                                                       for: indexPath) as? CustomNewsBrasilTableViewCell else { return UITableViewCell()}
       
        if let newsBrazil = viewModel.newsBrazilList?.results[indexPath.row] {
            cell.prepareCell(newsBrazil: newsBrazil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension NewsBrasilViewController: NewsBrazilViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.viewScreen.newsTableView.reloadData()
        }
    }
    
    func failure() {
        print("Falhou")
    }
    
    
}
