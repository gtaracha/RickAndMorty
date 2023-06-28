import Foundation

public protocol HttpClient {
    func fetch(_ request: URLRequest) async throws -> Data
}
