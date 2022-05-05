//
//  HomeViewController.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 24.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func setTitle(_ title: String)
    func setupCollectionView()
    func setSearchController(vc: SearchViewController)
    func setPageController (_ pageNumber : Int)
    func startTimer()
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var presenter: HomePresenterProtocol!
    @IBOutlet weak var pageController: UIPageControl!
    var currentPageIndex = 0
    var counter = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        sliderCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        collectionView.register(UINib(nibName: "UpComingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpComingCell")
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    

}

extension HomeViewController: HomeViewControllerProtocol {
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    func setPageController(_ pageNumber : Int) {
        self.pageController.numberOfPages = pageNumber
        self.pageController.addTarget(self, action: #selector(self.pagecontrollervalues(_:)), for: .valueChanged)
        startTimer()
    }
    
    
    func reloadData() {
        self.collectionView.reloadData()
        self.sliderCollectionView.reloadData()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
    }
    
    func setSearchController(vc: SearchViewController) {
        let searchController = UISearchController(searchResultsController: vc)
        searchController.searchBar.placeholder = "Search a Movie"
        searchController.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchController.searchResultsUpdater = vc
        searchController.searchBar.delegate = vc
        navigationItem.searchController = searchController
    }
    
}
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        self.currentPageIndex = Int(scrollView.contentOffset.x / width)
        self.pageController.currentPage = self.currentPageIndex
       }
    @objc func pagecontrollervalues(_ sender : UIPageControl){
        let index = sender.currentPage
        let indexPath = IndexPath.init(row: index, section: 0)
        currentPageIndex = index
        self.sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.pageController.currentPage = currentPageIndex
            
    }
    @objc func scrollAutomatically(_ timer1: Timer) {
        for cell in sliderCollectionView.visibleCells {
            if presenter.numberOfItems() == 1 {
                return
            }
            let indexPath = sliderCollectionView.indexPath(for: cell)!
            if indexPath.row < (presenter.numberOfItems() - 1) {
                let indexPath1 = IndexPath.init(row: indexPath.row + 1, section: indexPath.section)
                sliderCollectionView.scrollToItem(at: indexPath1, at: .right, animated: true)
                pageController.currentPage = indexPath1.row
            }
            else {
                let indexPath1 = IndexPath.init(row: 0, section: indexPath.section)
                sliderCollectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
                pageController.currentPage = indexPath1.row
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            
            let itemWidth: CGFloat = (UIScreen.main.bounds.width - ((2 + 1) * 10))/2
            let itemHeight: CGFloat = itemWidth * (3/2)
            return CGSize(width: itemWidth , height: itemHeight)

        }
        else {
            return CGSize(width: collectionView.frame.width  , height: sliderCollectionView.frame.height  )

        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return presenter.numberOfupComingItems()
        }
        else {
            return presenter.numberOfItems()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingCell", for: indexPath) as! UpComingCollectionViewCell
            if let source = presenter.upComingSource(indexPath.row) {
                cell.cellPresenter = UpComingCellPresenter(view: cell, source: source)
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            if let source = presenter.source(indexPath.row) {
                cell.cellPresenter = MovieCellPresenter(view: cell, source: source)
            }
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            presenter.didSelectRowAt(index: indexPath.row, cell: "upComingSource")
        }
        else {
            presenter.didSelectRowAt(index: indexPath.row, cell: "nowPlaying")
        }
        
    }
    
    
}
