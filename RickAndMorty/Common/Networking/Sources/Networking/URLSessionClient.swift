import Foundation
import Utilities

public struct URLSessionClient: HttpClient {
    public init() {}

    public func fetch(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        return try verifyResponse(data: data, response: response)
    }

    private func verifyResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }

        guard let error = APIError(status: httpResponse.statusCode) else {
            return data
        }

        throw error
    }

}
