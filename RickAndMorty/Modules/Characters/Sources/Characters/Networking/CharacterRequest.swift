import Foundation
import Networking

struct CharacterRequest: NetworkingRequest {
    let page: Int
    var path: String { "/character" }
    var queryItems: [URLQueryItem] { [URLQueryItem(name: "page", value: "\(page)")] }
}
