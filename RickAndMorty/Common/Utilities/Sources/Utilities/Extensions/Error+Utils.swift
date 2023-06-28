import Foundation

public enum APIError: Error {
    case badRequest
    case serverError
    case unknown

    public init?(status: Int) {
        switch status {
            case 200...299: return nil
            case 400...499: self = .badRequest
            case 500...599: self = .serverError
            default: self = .unknown
        }
    }
}

extension APIError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .badRequest: return "Bad request"
        case .serverError: return "Server Error"
        case .unknown: return "Unknown Error"
        }
    }
}

extension Error {
    var isConnectionFailureError: Bool {
        _code == NSURLErrorNotConnectedToInternet ||
        _code == NSURLErrorNetworkConnectionLost
    }

    var isHostError: Bool {
        _code == NSURLErrorCannotFindHost ||
        _code == NSURLErrorCannotConnectToHost
    }
}

public struct LocalizedAppError: LocalizedError {
    let error: Error

    public var errorDescription: String? {
        if error.isConnectionFailureError {
            return "No internet connection"
        }

        if error.isHostError {
            return "Connecting to host problem"
        }

        guard let apiError = error as? APIError else {
            return error.localizedDescription
        }

        return apiError.description
    }

    public init?(error: Error?) {
        guard let error else { return nil }
        self.error = error
    }
}
