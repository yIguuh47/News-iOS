import UIKit

protocol NewsViewControllerProtocol {
    func showError(errorMessage: String)
    func showArticles(_ articles: [Article])
}

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: NewsPresenterProtocol?
    private var interactor: NewsInteractorProtocol?
    
    private var articles: [Article] = []
    var urlToDetails: String!
    var router = NewsRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter = NewsPresenter(controller: self)
        interactor = NewsInteractor(presenter: presenter!)
        
        setupTableView()
        interactor?.loadNews()
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.setupCellCustom(model: self.articles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.articles[indexPath.row]
        if let url = article.url {
            self.urlToDetails = url
            performSegue(withIdentifier: "newsDetailsViewController", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Return Request News
extension NewsViewController: NewsViewControllerProtocol {
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            self.showAlert(message: errorMessage)
        }
    }
    
    func showArticles(_ articles: [Article]) {
        DispatchQueue.main.async {
            self.articles = articles
            self.tableView.reloadData()
        }
    }
    
    private func showAlert(title: String = "Atenção", message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}

// MARK: - Navigation
extension NewsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNewsSomewhere(segue: segue, urlDetails: urlToDetails)
    }
}
