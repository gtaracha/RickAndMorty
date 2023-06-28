import Foundation

public final class CharacterDetailsViewModel: ObservableObject {
    @Published var character: Character

    public init(character: Character) {
        self.character = character
    }
}
