//
//  HomeViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import UIKit

final class HomeViewController: UIViewController {

    lazy private var viewScreen: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func loadView() {
        self.view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        setupSearchController()
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.todayPostsTableView.delegate = self
        viewScreen.todayPostsTableView.dataSource = self
        viewScreen.mainNewsCollectionView.delegate = self
        viewScreen.mainNewsCollectionView.dataSource = self
    }
    
    private func setupSearchController() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTodayPostsTableViewCell.identifier,
                                                 for: indexPath) as? CustomTodayPostsTableViewCell
        
        return cell ?? UITableViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomMainNewsCollectionViewCell.identifier,
                                                      for: indexPath) as? CustomMainNewsCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
}
