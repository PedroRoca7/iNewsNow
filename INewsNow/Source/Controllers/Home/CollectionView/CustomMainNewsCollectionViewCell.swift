//
//  CustomMainNewsCollectionViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import UIKit
import Kingfisher

final class CustomMainNewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CustomMainNewsCollectionViewCell"
    
    lazy var viewScreen: CustomMainNewsCell = {
        let view = CustomMainNewsCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCollectionCell(mainNews: NewsData) {
        if let url = URL(string: mainNews.multimedia[1].url) {
            viewScreen.backgroundImageNewsImageView.kf.indicatorType = .activity
            viewScreen.backgroundImageNewsImageView.kf.setImage(with: url)
        }
        viewScreen.dateNewsLabel.text = formaterDate(date: mainNews.publishedDate)
        viewScreen.newsTextLabel.text = mainNews.abstract
        viewScreen.authorNewsLabel.text = mainNews.byline
    }
    
    private func formaterDate(date: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "MMMM dd, yyyy"
            let stringDate = formatter.string(from: date)
            return stringDate
        } else {
            return ""
        }
    }
}

extension CustomMainNewsCollectionViewCell: ViewProtocol {
    func buildHierarchy() {
        contentView.addSubview(viewScreen)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: self.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
