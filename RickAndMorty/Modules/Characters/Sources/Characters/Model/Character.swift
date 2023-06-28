import Foundation

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}

public struct Character: Decodable, Identifiable {
    public var id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterLocation
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

public struct Characters: Decodable {
    let info: Info
    let results: [Character]
}

extension Character: Equatable, Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension Character: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.id < rhs.id
    }

    public static func <= (lhs: Self, rhs: Self) -> Bool {
        lhs.id <= rhs.id
    }

    public static func >= (lhs: Self, rhs: Self) -> Bool {
        lhs.id >= rhs.id
    }

    public static func > (lhs: Self, rhs: Self) -> Bool {
        lhs.id > rhs.id
    }
}

struct ExampleCharacter {
    static let example1 = Character(id: 1,
                                   name: "Rick Sanche",
                                   status: "Alive",
                                   species: "Human",
                                   type: "",
                                   gender: "Male",
                                   origin: CharacterLocation(name: "Earth (C-137)",
                                                             url: "https://rickandmortyapi.com/api/location/1"),
                                   location: CharacterLocation(name: "Citadel of Ricks",
                                                               url: "https://rickandmortyapi.com/api/location/3"),
                                   image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                   episode: [],
                                   url: "https://rickandmortyapi.com/api/character/1",
                                   created: "1985")

    static let example2 = Character(id: 2,
                                   name: "Morty Smith",
                                   status: "Alive",
                                   species: "Human",
                                   type: "",
                                   gender: "Male",
                                   origin: CharacterLocation(name: "unknown",
                                                             url: ""),
                                   location: CharacterLocation(name: "Citadel of Ricks",
                                                               url: "https://rickandmortyapi.com/api/location/3"),
                                   image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                                   episode: [],
                                   url: "https://rickandmortyapi.com/api/character/2",
                                   created: "2017")
}

extension Character {
    func withId(_ id: Int) -> Character {
        var character = self
        character.id = id
        return character
    }
}
