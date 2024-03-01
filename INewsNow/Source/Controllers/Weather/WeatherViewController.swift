//
//  WeatherViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit

final class WeatherViewController: UIViewController {
    
    //MARK: - Propertys
    
    private lazy var viewScreen: WeatherView = {
        let view = WeatherView()
        return view
    }()
    
    private var viewModel: WeatherViewModeling
    
    //MARK: - Inits
    
    init(viewModel: WeatherViewModeling) {
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
    }
}
