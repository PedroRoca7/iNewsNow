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
    
    lazy var viewModel: MenuFilterNewsViewModel = {
        let viewModel = MenuFilterNewsViewModel()
        return viewModel
    }()
    
    override func loadView() {
        self.view = viewScreen
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setDelegatesAndDataSource()
    }
    
    private func setupNavigationBar() {
        self.tabBarController?.navigationItem.title = "Categorias"
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.menuCollectionView.dataSource = self
        viewScreen.menuCollectionView.delegate = self
    }
}
 
extension MenuFilterNewsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuFilterNewsCollectionViewCell.identifier,
                                                            for: indexPath) as? MenuFilterNewsCollectionViewCell else { return UICollectionViewCell()}
    
        let titleCategory = viewModel.categorys[indexPath.row]
        cell.prepareCollectionCell(titleCategory: titleCategory)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        let height = collectionView.frame.height / 4
        return CGSize(width: width, height: height)
    }
}


#if DEBUG
import SwiftUI

struct MenuFilterNews_Previews: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: MenuFilterNewsFactory.makeModule(navigationController: UINavigationController())
        )
        .asSwiftUIView
        .edgesIgnoringSafeArea(.all)
    }
}
#endif
