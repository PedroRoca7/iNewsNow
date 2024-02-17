//
//  CustomFavoriteNewsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit
import Kingfisher

final class CustomFavoriteNewsTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomFavoriteNewsTableViewCell"
    
    lazy var viewScreen: CustomFavoriteNewsCell = {
        let view = CustomFavoriteNewsCell()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(newsFavorited: Any) {
        
        if let mainNews = newsFavorited as? NewsData {
            viewScreen.textNewsLabel.text = mainNews.title
            viewScreen.authorNewsLabel.text = mainNews.byline
            viewScreen.dateNewsLabel.text = formaterDate(date: mainNews.publishedDate ?? "Date not Found",
                                                         typeNews: .mainNews)
            guard let notEmptyImageUrl = mainNews.multimedia?.first?.url, let url = URL(string: notEmptyImageUrl) else { return }
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url)
            viewScreen.imageNewsImageView.layer.cornerRadius = 10
        }

        if let mostPopularNews = newsFavorited as? PopularNewsData {
            viewScreen.textNewsLabel.text = mostPopularNews.title
            viewScreen.authorNewsLabel.text = mostPopularNews.byline
            viewScreen.dateNewsLabel.text = formaterDate(date: mostPopularNews.publishedDate ?? "Date not Found",
                                                         typeNews: .mostPopularNews)
            guard let notEmptyImageUrl = mostPopularNews.media?.first?.mediaMetadata?.first?.url, let url = URL(string: notEmptyImageUrl) else { return }
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url)
            viewScreen.imageNewsImageView.layer.cornerRadius = 10
        }
    }
    
    private func formaterDate(date: String, typeNews: TypeNews) -> String {
        
        switch typeNews {
        case .mostPopularNews:
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-mm-dd"
            if let date = formatter.date(from: date) {
                formatter.dateFormat = "MMMM dd, yyyy"
                let stringDate = formatter.string(from: date)
                return stringDate
            } else {
                return ""
            }
        case .mainNews :
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
}

extension CustomFavoriteNewsTableViewCell: ViewProtocol {
    func buildHierarchy() {
        contentView.addSubview(viewScreen)
        contentView.backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
