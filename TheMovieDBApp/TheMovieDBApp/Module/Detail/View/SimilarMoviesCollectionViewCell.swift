//
//  SimilarMoviesCollectionViewCell.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import UIKit

protocol SimilarCellProtocol: AnyObject{
    func setDetailImageView(_ imageUrl: String)
    func setTitleLabel(_ text: String)

}

final class SimilarMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    var cellPresenter: SimilarCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension SimilarMoviesCollectionViewCell: SimilarCellProtocol {
    func setTitleLabel(_ text: String) {
        self.movieTitle.text = text
    }
    
    func setDetailImageView(_ imageUrl: String) {
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
    

}
