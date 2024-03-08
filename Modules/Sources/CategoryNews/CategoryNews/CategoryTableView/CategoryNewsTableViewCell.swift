//
//  CategoryNewsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit
import INewsNowCore

protocol CategoryNewsTableViewCellDelegate: AnyObject {
    func favoriteButtonTapped(cell: UITableViewCell)
}

final class CategoryNewsTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryNewsTableViewCell"

    weak var delegate: CategoryNewsTableViewCellDelegate?
    
    lazy var viewScreen: CategoryNewsCell = {
        let view = CategoryNewsCell()
        return view
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        delegate?.favoriteButtonTapped(cell: self)
    }

    func prepareCell(categoryNewsBrazil: Article) {
        let placeHolderImage = UIImage(named: "LogoINewsNow")
        viewScreen.titleNews.text = categoryNewsBrazil.title
        viewScreen.authorLabel.text = categoryNewsBrazil.sourceId
        viewScreen.dateLabel.text = DateFormatter.formatterDate(dateString: categoryNewsBrazil.pubDate, locale: .brazil)
        if let url = URL(string: categoryNewsBrazil.imageURL) {
//            viewScreen.imageNewsImageView.kf.indicatorType = .activity
//            viewScreen.imageNewsImageView.kf.setImage(with: url, placeholder: placeHolderImage)
        } else {
            viewScreen.imageNewsImageView.image = placeHolderImage
        }
    }
}

extension CategoryNewsTableViewCell: ViewProtocol {
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
        contentView.backgroundColor = .clear
        viewScreen.favoriteNewsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
