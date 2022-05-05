
import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfSearchItems() -> Int
    func fetchSearchResults (query:String)
    func searchSource(index: Int) -> SearchResults?
    func didSelectRowAt(index: Int)
}

final class SearchPresenter: SearchPresenterProtocol {
    


    unowned var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
    private var sources: [SearchResults] = []
    
    init(view: SearchViewControllerProtocol, router: SearchRouterProtocol, interactor: SearchInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setTitle("Filmler")
    }
    
    func numberOfSearchItems() -> Int {
        return sources.count
    }
    
    func searchSource(index: Int) -> SearchResults? {
        return sources[index]
    }
    

    func didSelectRowAt(index: Int) {
        var movieId:Int!
        guard let source = searchSource(index: index) else { return }

        movieId = source.id

        router.navigate(.detail(source: movieId))
    }
    
    func fetchSearchResults(query : String) {
        interactor.fetchSearch(with: query)
    }
}

extension SearchPresenter : SearchInteractorOutputProtocol {
    func fetchSearchOutput(result: SearchResult) {
        switch result {
            
        case .success(let sourcesResult):
            sources = sourcesResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    }
