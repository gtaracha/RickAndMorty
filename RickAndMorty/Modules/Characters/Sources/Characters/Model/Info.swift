import Foundation

public struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
