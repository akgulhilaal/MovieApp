//
//  MovieDetailViewController.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import UIKit
import Kingfisher

protocol MovieDetailViewControllerProtocol: AnyObject {
    func reloadData()
    func id() -> Int
    func setupCollectionView()
    func setmovieImage(_ imageUrl: String)
    func setmovieTitle(_ text: String)
    func setmovieDescription(_ text: String)
    func setmoviedateLabel(_ text: String)
    func setmoviescoreLabel(_ text: String)
    func setImdbUrl(_ text: String)
    func setFavoriteButtonTitle(_ text: String)
}

final class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var presenter: MovieDetailPresenterProtocol!
    var source: Int = 0
    var imdbUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        similarCollectionView.register(UINib(nibName: "SimilarMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarCell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if FavoriteMovies.shared.isFavorite(source) == true{
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    @IBAction func showImdb(_ sender: Any) {
        if let url = URL(string: self.imdbUrl) {
            UIApplication.shared.open(url)
        }
    }

    @IBAction func addFavorites(_ sender: Any) {
        presenter.isFavorite(id: source)
    }
}
extension MovieDetailViewController : MovieDetailViewControllerProtocol{


    func setFavoriteButtonTitle(_ text: String) {
        self.favoriteButton.setTitle(nil, for: .normal) 
        self.favoriteButton.setImage(UIImage(systemName: text), for: .normal)

    }
    
    func setImdbUrl(_ text: String) {
        self.imdbUrl = text
    }
    
    func setupCollectionView() {
        self.similarCollectionView.delegate = self
        self.similarCollectionView.dataSource = self
    }
    
    func setmovieDescription(_ text: String) {
        self.movieDescription.text = text
    }
    
    func setmoviedateLabel(_ text: String) {
        self.dateLabel.text = text
    }
    
    func setmoviescoreLabel(_ text: String) {
        self.scoreLabel.text = text
    }
    
    func setmovieImage(_ imageUrl: String) {
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
    
    func setmovieTitle(_ text: String) {
        self.movieTitle.text = text
    }
    
    func id() -> Int {
        return source
    }
    
    func setDescriptionLabel(_ text: String) {
        self.movieDescription.text = text
    }
    
    func reloadData() {
        self.similarCollectionView.reloadData()
    }
    
    
}
extension MovieDetailViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCell", for: indexPath) as! SimilarMoviesCollectionViewCell
        if let source = presenter.detailsSource(indexPath.row) {
            cell.cellPresenter = SimilarMoviesPresenter(view: cell, source: source)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter.didSelectRowAt(index: indexPath.row)

    }
    
    
}
