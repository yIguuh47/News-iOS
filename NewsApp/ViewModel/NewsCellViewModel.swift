import Foundation

class NewsCellViewModel {
    
    private var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var photoUrl: URL? {
        return URL(string: self.article.urlToImage)
    }
    
    var title: String {
        return self.article.title
    }
    
    var description: String {
        return self.article.description
    }
    
    var urlArticle: String {
        return self.article.url
    }
    
}
