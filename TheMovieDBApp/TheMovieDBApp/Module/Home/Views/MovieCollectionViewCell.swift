//
//  MovieCollectionViewCell.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 28.04.2022.
//

import UIKit
import Kingfisher


protocol MovieCellProtocol: AnyObject{
    func setMovieImageView(_ imageUrl: String)
    func setTitleLabel(_ text: String)
    func setDescrLabel(_ text: String)
}

final class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    var cellPresenter: MovieCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension MovieCollectionViewCell: MovieCellProtocol {
    func setTitleLabel(_ text: String) {
        self.movieTitle.text = text
    }
    
    func setDescrLabel(_ text: String) {
        self.descrLabel.text = text
    }
    
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
    

}
