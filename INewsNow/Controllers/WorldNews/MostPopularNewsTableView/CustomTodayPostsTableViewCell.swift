//
//  CustomMostPopularPostsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import UIKit

final class CustomMostPopularPostsTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomMostPopularPostsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
