import Foundation
import Networking
import Utilities

public protocol CharacterListNetworkServicing {
    typealias CharactersResponse = Characters

    func fetchCharacters(page: Int) async throws -> CharactersResponse
}

public struct CharacterListNetworkService: CharacterListNetworkServicing {
    private let client: HttpClient

    public init(client: HttpClient) {
        self.client = client
    }

    public func fetchCharacters(page: Int) async throws -> CharactersResponse {
        let request = CharacterRequest(page: page).buildURLRequest()
        let data = try await client.fetch(request)
        return try data.decodeJson(CharactersResponse.self)
    }
}
