//
//  UpComingCollectionViewCell.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import UIKit
import Kingfisher

protocol UpComingCellProtocol: AnyObject{
    func setTitleLabel(_ text: String)
    func setMovieImageView(_ imageUrl: String)
}

class UpComingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    var cellPresenter: UpComingCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.lightText
        layerView.backgroundColor = UIColor.purple.withAlphaComponent(0.12)
        
        layerView.bringSubviewToFront(movieImage)
   }

}
extension UpComingCollectionViewCell: UpComingCellProtocol {
    func setMovieImageView(_ imageUrl: String) {
        let url = URL(string: imageUrl)
        movieImage.kf.indicatorType = .activity
        
        movieImage.kf.setImage(with: url) { result in
            
            switch result {
                
            case .success(_):
                break
            case .failure(_):
                self.movieImage.image = UIImage(systemName: "no-pictures")
            }
        }
    }
    
    
    func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
    }
}
