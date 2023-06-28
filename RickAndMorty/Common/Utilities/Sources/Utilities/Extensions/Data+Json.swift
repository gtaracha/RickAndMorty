import Foundation

extension Data {
    public func decodeJson<T: Decodable>(_ type: T.Type,
                                         dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601,
                                         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) throws -> T {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        return try decoder.decode(T.self, from: self)
    }
}
