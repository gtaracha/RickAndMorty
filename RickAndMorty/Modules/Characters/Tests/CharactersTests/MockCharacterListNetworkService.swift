import Foundation
@testable import Characters

class MockCharacterListNetworkService: CharacterListNetworkServicing {
    func fetchCharacters(page: Int) async throws -> CharactersResponse {
        let characters1 = [ExampleCharacter.example1, ExampleCharacter.example2, ExampleCharacter.example1,
                           ExampleCharacter.example2, ExampleCharacter.example1, ExampleCharacter.example2,
                           ExampleCharacter.example1, ExampleCharacter.example2, ExampleCharacter.example2,
                           ExampleCharacter.example2, ExampleCharacter.example1, ExampleCharacter.example1,
                           ExampleCharacter.example2, ExampleCharacter.example1, ExampleCharacter.example2,
                           ExampleCharacter.example1, ExampleCharacter.example2, ExampleCharacter.example1,
                           ExampleCharacter.example2, ExampleCharacter.example2, ExampleCharacter.example2,
                           ExampleCharacter.example1]
            .enumerated().map { (index, character) in
            character.withId(index)
        }
        let characters2 = characters1.enumerated().map { (index, character) in
            character.withId(index + characters1.count)
        }

        let info1 = Info(count: characters1.count * 2, pages: 2, next: "url", prev: nil)
        let info2 = Info(count: characters1.count * 2, pages: 2, next: nil, prev: "prev")

        return page == 1 ? Characters(info: info1, results: characters1) : Characters(info: info2, results: characters2)
    }
}
