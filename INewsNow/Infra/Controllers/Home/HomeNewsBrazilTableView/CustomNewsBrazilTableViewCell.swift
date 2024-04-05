//
//  CustomNewsBrazilTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

protocol CustomNewsBrazilTableViewCellDelegate: AnyObject {
    func favoriteButtonTapped(cell: UITableViewCell)
}

final class CustomNewsBrazilTableViewCell: UITableViewCell {
    
    static let identifier = "CustomNewsBrazilTableViewCell"
    
    lazy var viewScreen: CustomNewsBrazilCell = {
        let view = CustomNewsBrazilCell()
        return view
    }()
    
    weak var delegate: CustomNewsBrazilTableViewCellDelegate?
    
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
    
    func prepareCell(newsBrazil: Article) {
        let placeHolderImage = UIImage(named: "LogoINewsNow")
        viewScreen.titleNews.text = newsBrazil.title
        viewScreen.authorLabel.text = newsBrazil.sourceId
        viewScreen.dateLabel.text = DateFormatter.formatterDate(dateString: newsBrazil.pubDate, locale: .brazil)
        if let url = URL(string: newsBrazil.imageURL) {
            viewScreen.imageNewsImageView.kf.indicatorType = .activity
            viewScreen.imageNewsImageView.kf.setImage(with: url, placeholder: placeHolderImage)
        } else {
            viewScreen.imageNewsImageView.image = placeHolderImage
        }
    }
    
    
}

extension CustomNewsBrazilTableViewCell: ViewProtocol {
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
        viewScreen.favoriteNewsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
