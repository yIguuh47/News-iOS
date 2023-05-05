import Foundation

enum CustomError: String , Error {
    case loadDataResponse = "Error ao carregar dados"
    case urlLoad = "Erro ao carregar URL"
    case titleError = "Erro"
}

enum StatusCode: Int {
    case successRequest
    case badRequest
    
    var range: Range<Int> {
        switch self {
        case .successRequest: return 200..<300
        case .badRequest: return 400..<500
        }
    }
}

protocol ErrorHandlerProtocol: LocalizedError {
    
    var title: String? {get}
    var code: Int {get}
}

struct ErrorHandler: ErrorHandlerProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
    
    init(error: Error, code: Int) {
        self.title = "Error"
        self._description = error.localizedDescription
        self.code = code
    }
}
