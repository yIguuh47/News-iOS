import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "News"
        view.backgroundColor = .systemBackground
        
        
        viewModel = ListNewsViewModel(delegate: self)
        viewModel.loadNews()
        configTableView()
    }
    
    func configTableView(){
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.setupCellCustom(model: self.viewModel.loadCurrentNews(indexPath: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let new = self.viewModel.loadCurrentNews(indexPath: indexPath)
        guard let url = URL(string: new.url) else { return }
                UIApplication.shared.open(url)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadData() {
        self.viewModel.loadNews()
    }
    
}

extension NewsViewController: ListNewsViewModelProtocol {
    func failure(error: ErrorHandler) {
        DispatchQueue.main.async {
            self.showAlert(title: error.title, message: error.errorDescription, titleBtn: "Ok")
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func showAlert(title: String?, message: String?, titleBtn: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: titleBtn, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
