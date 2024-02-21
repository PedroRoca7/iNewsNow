//
//  CustomNewsBrasilTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class CustomNewsBrasilTableViewCell: UITableViewCell {
    
    static let identifier = "CustomNewsBrasilTableViewCell"
    
    lazy var viewScreen: CustomNewsBrasilCell = {
        let view = CustomNewsBrasilCell()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func prepareCell(newsBrazil: Article) {
        viewScreen.titleNews.text = newsBrazil.title
        viewScreen.authorLabel.text = newsBrazil.sourceId
        viewScreen.dateLabel.text = DateFormatter.formatterDate(dateString: newsBrazil.pubDate, locale: .brazil)
        if let url = URL(string: newsBrazil.imageURL) {
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url)
        } else {
            viewScreen.imageNewsImageView.image = UIImage(named: "LogoINewsNow")
        }
    }
    
    
}

extension CustomNewsBrasilTableViewCell: ViewProtocol {
    func buildHierarchy() {
        contentView.addSubview(viewScreen)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .clear
        viewScreen.clipsToBounds = true
    }
}
