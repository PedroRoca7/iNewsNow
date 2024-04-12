//
//  HomeTableViewDataSource.swift
//  INewsNow
//
//  Created by Pedro Henrique on 12/04/24.
//

import UIKit

protocol HomeTableViewDataSourceDelegate: NSObject {
    func cellClicked(newsObject: Article)
    func favoritedButtonClicked(index: Int)
}

final class HomeTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var content: NewsBrazilModel?
    weak var delegate: HomeTableViewDataSourceDelegate?
    
    func reloadTableView(with content: NewsBrazilModel) {
        self.content = content
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomNewsBrazilTableViewCell.identifier,
                                                       for: indexPath) as? CustomNewsBrazilTableViewCell else { return UITableViewCell()}
       
        cell.buttonClicked = { [weak self] buttonCell in
            guard let self = self,
                  let indexPathTapped = tableView.indexPath(for: buttonCell)  else { return }
            self.content?.results[indexPathTapped.row].favorite.toggle()
            self.delegate?.favoritedButtonClicked(index: indexPathTapped.row)
            tableView.reloadRows(at: [indexPathTapped], with: .none)
        }
        
        if let newsBrazil = content?.results[indexPath.row] {
            cell.viewScreen.favoriteNewsButton.tintColor = newsBrazil.favorite ? UIColor.red : UIColor.gray
            cell.prepareCell(newsBrazil: newsBrazil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = content?.results[indexPath.row] else { return }
        delegate?.cellClicked(newsObject: object)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
