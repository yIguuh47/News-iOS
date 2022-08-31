import Foundation

struct NewsModel: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}



