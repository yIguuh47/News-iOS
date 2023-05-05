import Foundation

protocol NewsPresenterProtocol: AnyObject {
    func presenteError(errorMessage: String)
    func presenteArticles(_ articles: [Article])
}

class NewsPresenter: NewsPresenterProtocol {

    weak var controller: NewsViewController?
    
    init(controller: NewsViewController) {
        self.controller = controller
    }
    
    func presenteError(errorMessage: String) {
        controller?.showError(errorMessage: errorMessage)
    }
    
    func presenteArticles(_ articles: [Article]) {
        controller?.showArticles(articles)
    }
    
}
