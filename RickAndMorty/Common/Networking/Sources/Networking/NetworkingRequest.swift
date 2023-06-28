import Foundation
import Utilities

public protocol NetworkingRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem] { get }
    var basePath: String { get }

    func buildURLRequest() -> URLRequest
}

extension URL {
    func appendQueryItems(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        return urlComponents.url
    }
}

public extension NetworkingRequest {
    var method: HTTPMethod { .GET }
    var headers: [String: String] { [:] }
    var body: Data? { nil }
    var queryItems: [URLQueryItem] { [] }
    var basePath: String {
        guard let basePath = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("baseURL must not be empty in plist")
        }
        return basePath
    }

    func buildURLRequest() -> URLRequest {
        guard let baseURL = URL(string: basePath) else { fatalError("Wrong base path") }
        var pathURL = baseURL.appendingPathComponent(path)
        pathURL = pathURL.appendQueryItems(queryItems) ?? pathURL
        var urlRequest = URLRequest(url: pathURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body

        return urlRequest
    }
}

public enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
  case PATCH
}

class NetworkConfiguration {
    public static let shared = NetworkConfiguration()

    var apiBaseURL: String

    private init() {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        self.apiBaseURL = apiBaseURL
    }
}
