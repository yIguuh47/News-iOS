//
//  NewsRouter.swift
//  NewsApp
//
//  Created by Igor Damasceno de Sousa on 03/05/23.
//

import Foundation
import UIKit

protocol NewsDateRouter {
    func newsDetailsDate(urlDetails: String)
}

class NewsRouter {
    
    weak var viewController: NewsViewController!

    func passDataToNextScene(segue: UIStoryboardSegue, urlToDetails: String?) {
        if segue.identifier == "newsDetailsViewController" && urlToDetails != nil {
          passDataToNewsSomewhere(segue: segue, urlDetails: urlToDetails ?? "")
        }
    }
    
    func passDataToNewsSomewhere(segue: UIStoryboardSegue, urlDetails: String) {
          guard let someWhereNewsVC = segue.destination as? NewsDetailsViewController else {return}
          someWhereNewsVC.newsDetailsDate(urlDetails: urlDetails)
    }
    
}

