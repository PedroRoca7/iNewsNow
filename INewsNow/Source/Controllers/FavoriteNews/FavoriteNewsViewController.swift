//
//  FavoriteNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit
import CoreData

final class FavoriteNewsViewController: UIViewController {
    
    lazy var viewScreen: FavoriteNewsView = {
        let view = FavoriteNewsView()
        return view
    }()

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
        DispatchQueue.main.async {
            self.viewScreen.favoriteNewsTableView.reloadData()
        }
    }
    
    private func loadNewsCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteNews")
        
        do {
            HomeViewModel.favoritedNewsArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Erro ao carregar dados do banco \(error.localizedDescription)")
        }
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.favoriteNewsTableView.delegate = self
        viewScreen.favoriteNewsTableView.dataSource = self
    }
}

extension FavoriteNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewModel.favoritedNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomFavoriteNewsTableViewCell.identifier,
                                                       for: indexPath) as? CustomFavoriteNewsTableViewCell else { return UITableViewCell()}

       
        let newsFavorited = HomeViewModel.favoritedNewsArray[indexPath.row]
        cell.prepareCell(newsFavorited: newsFavorited)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
