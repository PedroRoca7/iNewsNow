//
//  DetailsNewsViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 21/02/24.
//

import Foundation
import UIKit
import Kingfisher

final class DetailsNewsViewController<T>: UIViewController {
    
    //MARK: Propertys
    
    lazy var viewScreen: DetailsNewsView = {
        let view = DetailsNewsView()
        return view
    }()
    
    var content: T

    init(content: T) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Inits
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifedTypeObject()
    }
    
    private func verifedTypeObject() {
        if let newsData = content as? NewsData {
            prepareScreenNewsData(date: newsData)
        } else if let article = content as? Article {
            prepareScreenArticle(date: article)
        } else if let popularNewsData = content as? PopularNewsData {
            prepareScreenPopularNewsData(date: popularNewsData)
        }
    }
    
    private func prepareScreenNewsData(date: NewsData) {
        viewScreen.titleNewsLabel.text = date.title
        viewScreen.textDescriptionNewsLabel.text = date.abstract
        guard let nonEmptyImageUrl = date.multimedia.first?.url else { return }
        if let url = URL(string: nonEmptyImageUrl) {
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url)
        }
    }
    
    private func prepareScreenArticle(date: Article) {
        viewScreen.titleNewsLabel.text = date.title
        viewScreen.textDescriptionNewsLabel.text = date.description
        if let url = URL(string: date.imageURL) {
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url)
        }
    }
    
    private func prepareScreenPopularNewsData(date: PopularNewsData) {
        viewScreen.titleNewsLabel.text = date.title
        viewScreen.textDescriptionNewsLabel.text = date.abstract
        guard let nonEmptyImageUrl = date.media.first?.mediaMetadata.first?.url else { return }
        if let url = URL(string: nonEmptyImageUrl) {
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url)
        }
    }
}
