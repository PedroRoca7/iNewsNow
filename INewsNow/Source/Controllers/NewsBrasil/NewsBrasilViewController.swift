//
//  NewsBrasilViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class NewsBrasilViewController: UIViewController {
    
    lazy var viewScreen: NewsBrasilView = {
        let view = NewsBrasilView()
        return view
    }()
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupDelegateAndDataSource() {
        viewScreen.newsTableView.delegate = self
        viewScreen.newsTableView.dataSource = self
    }
}

extension NewsBrasilViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
