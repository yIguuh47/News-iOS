import Foundation

protocol ListNewsViewModelProtocol: AnyObject {
    func failure(error: ErrorHandler)
    func success()
}

class ListNewsViewModel {
    
    private let service = Service()
    private weak var delegate: ListNewsViewModelProtocol?
    
    private var newsList: [Article] = []
    
    var count: Int {
        return self.newsList.count
    }
    
    func loadCurrentNews(indexPath: IndexPath) -> Article {
        return self.newsList[indexPath.row]
    }
    
    init(delegate: ListNewsViewModelProtocol?) {
        self.delegate = delegate
    }
    
    func loadNews() {
        service.requestTopSotries { news, err in
            self.handle(news, err)
        }
    }
    
    func handle(_ news: [Article]?, _ error: ErrorHandler?) {
        if let e = error {
            self.delegate?.failure(error: e)
        }
        
        if let news = news {
            self.newsList = news
            self.delegate?.success()
        }
    }
    
    
}
