//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Igor Damasceno de Sousa on 01/05/23.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController, WKNavigationDelegate {

    var urlToDetails: URL?
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let urlDet = urlToDetails {
            webView.load(URLRequest(url: urlDet))
            webView.allowsBackForwardNavigationGestures = true
        }
   
    }
}

//MARK: - Date navigation
extension NewsDetailsViewController: NewsDateRouter {
    func newsDetailsDate(urlDetails: String) {
        guard let urlCaptured = URL(string: urlDetails) else { return }
        urlToDetails = urlCaptured
    }
}


