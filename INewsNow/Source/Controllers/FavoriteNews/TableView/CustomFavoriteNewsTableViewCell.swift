//
//  CustomFavoriteNewsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit

final class CustomFavoriteNewsTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomFavoriteNewsTableViewCell"
    
    lazy var viewScreen: CustomFavoriteNewsCell = {
        let view = CustomFavoriteNewsCell()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(newsFavorited: NewsProtocol) {
        viewScreen.textNewsLabel.text = newsFavorited.title
        viewScreen.authorNewsLabel.text = newsFavorited.byline
        if let nonEmptyImageUrl = newsFavorited.media.first?.mediaMetadata?.first?.url {
            viewScreen.dateNewsLabel.text = formaterDate(date: newsFavorited.publishedDate ?? "Date not Found",
                                                         typeNews: .mostPopularNews)
            if let url = URL(string: nonEmptyImageUrl) {
                viewScreen.imageNewsImageView.kf.indicatorType = .activity
                viewScreen.imageNewsImageView.kf.setImage(with: url)
                viewScreen.imageNewsImageView.layer.cornerRadius = 10
            }
        }
        if let nonEmptyImageUrl = newsFavorited.multimedia.first?.url {
            viewScreen.dateNewsLabel.text = formaterDate(date: newsFavorited.publishedDate ?? "Date not Found",
                                                         typeNews: .mainNews)
            if let url = URL(string: nonEmptyImageUrl) {
                viewScreen.imageNewsImageView.kf.indicatorType = .activity
                viewScreen.imageNewsImageView.kf.setImage(with: url)
                viewScreen.imageNewsImageView.layer.cornerRadius = 10
            }
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

