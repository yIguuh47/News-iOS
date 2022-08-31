import Foundation

private let apiURL = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=9d25345ac4ad4cbfb7ca96b6a1466722"

class Service {
    
    func requestTopSotries (completion: @escaping ([Article]?, ErrorHandler?) -> Void) {
        
        guard let api = URL(string: apiURL) else {
            completion(nil, ErrorHandler(title: ErrorDefault.titleError.rawValue, description: ErrorDefault.urlLoad.rawValue, code: StatusCode.badRequest.rawValue))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: api) { data, response, error in
            
            guard let _response = response as? HTTPURLResponse else {
                completion(nil, ErrorHandler(title: ErrorDefault.titleError.rawValue, description: ErrorDefault.loadDataResponse.rawValue, code: StatusCode.badRequest.rawValue))
                return
            }
            
            guard let jsonData = data else {
                completion(nil, ErrorHandler(title: ErrorDefault.titleError.rawValue, description: ErrorDefault.loadDataResponse.rawValue, code: StatusCode.badRequest.rawValue))
                return
            }
            
            switch _response.statusCode {
                
            case StatusCode.successRequest.range:
                
                do {
                    let decoder = JSONDecoder()
                    print(jsonData)
                    let model = try decoder.decode(NewsModel.self, from: jsonData)
                    completion(model.articles ,nil)
                } catch let error {
                    print(error)
                    completion(nil, ErrorHandler(error: error, code: _response.statusCode))
                }
                
            default:
                if let _error: Error = error {
                    completion(nil, ErrorHandler(error: _error, code: _response.statusCode))
                } else {
                    completion(nil, ErrorHandler(title: ErrorDefault.titleError.rawValue, description: ErrorDefault.loadDataResponse.rawValue, code: _response.statusCode))
                }
            }
        }
        task.resume()
    }
}
