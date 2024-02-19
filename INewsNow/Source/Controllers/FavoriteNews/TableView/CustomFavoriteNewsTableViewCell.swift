//
//  CustomFavoriteNewsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit
import Kingfisher
import CoreData

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
    
    func prepareCell(newsFavorited: NSManagedObject) {
        
        viewScreen.textNewsLabel.text = newsFavorited.value(forKey: "title") as? String
        viewScreen.authorNewsLabel.text = newsFavorited.value(forKey: "byline") as? String
        viewScreen.dateNewsLabel.text = formaterDate(dataString: newsFavorited.value(forKey: "publishedDate") as? String ?? "")
        guard let notEmptyImageUrl = newsFavorited.value(forKey: "urlImage") as? String, let url = URL(string: notEmptyImageUrl) else { return }
        viewScreen.imageNewsImageView.kf.indicatorType = .activity
        viewScreen.imageNewsImageView.kf.setImage(with: url)
        viewScreen.imageNewsImageView.layer.cornerRadius = 10

    }
    
    func formaterDate(dataString: String) -> String {
        let dateFormatterInput1 = DateFormatter()
        dateFormatterInput1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterInput1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterInput2 = DateFormatter()
        dateFormatterInput2.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterInput2.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterOutput.dateFormat = "MMMM dd, yyyy"
        
        if let data = dateFormatterInput1.date(from: dataString) ?? dateFormatterInput2.date(from: dataString) {
            return dateFormatterOutput.string(from: data)
        }
        
        return ""
    }}

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
