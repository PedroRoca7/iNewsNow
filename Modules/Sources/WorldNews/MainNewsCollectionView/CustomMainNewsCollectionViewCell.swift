//
//  CustomMainNewsCollectionViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import UIKit
//import Kingfisher
import INewsNowCore

protocol CustomMainNewsCollectionViewCellDelegate: AnyObject {
    func favoriteButtonTapped(cell: UICollectionViewCell)
}

final class CustomMainNewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CustomMainNewsCollectionViewCell"
    weak var delegate: CustomMainNewsCollectionViewCellDelegate?
    
    lazy var viewScreen: CustomMainNewsCell = {
        let view = CustomMainNewsCell()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        viewScreen.favoriteNewsButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favoriteButtonTapped() {
        delegate?.favoriteButtonTapped(cell: self)
    }
    
    func prepareCollectionCell(mainNews: NewsData) {
        viewScreen.dateNewsLabel.text = DateFormatter.formatterDate(dateString: mainNews.publishedDate, locale: .unitedStates)
        viewScreen.newsTextLabel.text = mainNews.title
        viewScreen.authorNewsLabel.text = mainNews.byline
        guard let nonEmptyImageUrl = mainNews.multimedia.first?.url else {
            viewScreen.backgroundImageNewsImageView.image = UIImage(named: "LogoINewsNow")
            return }
//        if let url = URL(string: nonEmptyImageUrl) {
//            viewScreen.backgroundImageNewsImageView.kf.indicatorType = .activity
//            viewScreen.backgroundImageNewsImageView.kf.setImage(with: url)
//        }
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
