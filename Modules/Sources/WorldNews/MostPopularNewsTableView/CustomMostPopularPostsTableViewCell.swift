//
//  CustomMostPopularPostsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import UIKit
//import Kingfisher
import INewsNowCore

protocol CustomMostPopularPostsTableViewCellDelegate: AnyObject {
    func favoriteButtonTapped(cell: UITableViewCell)
}

final class CustomMostPopularPostsTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomMostPopularPostsTableViewCell"
    weak var delegate: CustomMostPopularPostsTableViewCellDelegate?
    
    lazy var viewScreen: CustomMostPopularPostsCell = {
        let view = CustomMostPopularPostsCell()
        return view
    }()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
        viewScreen.favoriteNewsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.favoriteButtonTapped(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(mostPopularPost: PopularNewsData) {
        viewScreen.textNewsLabel.text = mostPopularPost.title
        viewScreen.authorNewsLabel.text = mostPopularPost.byline
        viewScreen.dateNewsLabel.text = DateFormatter.formatterDate(dateString: mostPopularPost.publishedDate, locale: .unitedStates)
        guard let nonEmptyImageUrl = mostPopularPost.media.first?.mediaMetadata.first?.url else { return }
        if let url = URL(string: nonEmptyImageUrl) {
//            viewScreen.imageNewsImageView.kf.indicatorType = .activity
//            viewScreen.imageNewsImageView.kf.setImage(with: url)
            viewScreen.imageNewsImageView.layer.cornerRadius = 10
        }
    }
}

extension CustomMostPopularPostsTableViewCell: ViewProtocol {
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
