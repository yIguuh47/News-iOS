import Foundation

private let apiURL = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=9d25345ac4ad4cbfb7ca96b6a1466722"

class ServiceNews {
    
    func requestTopSotries (onSuccess: @escaping ([Article]) -> Void, onFailure: @escaping (Error) -> Void) {
        
        guard let api = URL(string: apiURL) else {
            onFailure(CustomError.urlLoad)
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: api) { data, response, error in
            
            guard let _response = response as? HTTPURLResponse else {
                onFailure(CustomError.loadDataResponse)
                return
            }
            
            guard let jsonData = data else {
                onFailure(CustomError.loadDataResponse)
                return
            }
            
            if StatusCode.successRequest.range.contains(_response.statusCode) {
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(NewsModel.self, from: jsonData)
                    onSuccess(model.articles)
                } catch let error {
                    onFailure(error)
                }
            } else {
                onFailure(CustomError.loadDataResponse)
            }
            
        }
        task.resume()
    }
}
