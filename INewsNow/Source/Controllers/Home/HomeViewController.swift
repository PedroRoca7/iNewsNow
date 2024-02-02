//
//  HomeViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import UIKit

class HomeViewController: UIViewController {

    lazy private var viewScreen: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func loadView() {
        self.view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

