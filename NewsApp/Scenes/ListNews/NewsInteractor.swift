//
//  NewsInteractor.swift
//  NewsApp
//
//  Created by Igor Damasceno de Sousa (P) on 18/04/23.
//

import Foundation

protocol NewsInteractorProtocol {
    func loadNews()
}

class NewsInteractor: NewsInteractorProtocol {
    
    private let service = ServiceNews()
    private let presenter: NewsPresenterProtocol?
    
    init(presenter: NewsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadNews() {
        service.requestTopSotries { articles in
            self.presenter?.presenteArticles(articles)
        } onFailure: { error in
            self.presenter?.presenteError(errorMessage: error.localizedDescription)
        }

    }
    
}

