//
//  SearchViewController.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 1.05.2022.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func reloadData()
    func setTitle(_ title: String)
    func setupTableView()
}


class SearchViewController: BaseViewController {
    var presenter: SearchPresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCell")

    }
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

extension SearchViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let text = searchBar.text!
        if text.count >= 2 {
            presenter.fetchSearchResults(query: text)
        }
        else{
            presenter.fetchSearchResults(query: "")
        }
    }
    
}
extension SearchViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfSearchItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        if let source = presenter.searchSource(index: indexPath.row) {
            cell.cellPresenter = SearchCellPresenter(view: cell, source: source)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
}
