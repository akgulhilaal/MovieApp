//
//  SearchTableViewCell.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 1.05.2022.
//

import UIKit

protocol SearchCellProtocol: AnyObject{
    func setTitleLabel(_ text: String)
}

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var cellPresenter: SearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension SearchTableViewCell: SearchCellProtocol {
    
    func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
    }
}
