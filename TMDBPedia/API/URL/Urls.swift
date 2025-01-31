import UIKit
import Alamofire

enum MovieRouter {
    case getTrending(page: Int)
    case getSearchMovie(keyword: String, page: Int)
    case getMovieImages(movieId: Int)
    case getMovieCredits(movieId: Int)
}

extension MovieRouter: URLRequestConvertible {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("baseURL Error")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getTrending:
            return "trending/movie/day"
        case .getSearchMovie:
            return "search/movie"
        case .getMovieImages(let movieId):
            return "movie/\(movieId)/images"
        case .getMovieCredits(let movieId):
            return "movie/\(movieId)/credits"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTrending, .getSearchMovie, .getMovieImages, .getMovieCredits:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Bearer \(APIKey.read)", "accept": "application/json"]
    }
    
    var parameters: Parameters? {
        switch self {
        case .getTrending(let page):
            return ["language": "ko-KR", "page": page]
        case .getSearchMovie(let keyword, let page):
            return ["query" : keyword, "include_adult" : false, "language" : "ko-KR", "page" : page]
        case .getMovieImages:
            return nil
        case .getMovieCredits:
            return ["language": "ko-KR"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.method = method
        urlRequest.headers = headers
        
        if let parameters = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
