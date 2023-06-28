import Foundation
import Utilities

public final class CharacterListViewModel: ObservableObject {
    @Published var state: FetchState = .good
    @Published var filteredCharacters: [Character] = []
    @Published var characters: [Character] = []
    @Published var favoriteCharacters: Set<Character> = []
    var searchText: String = "" {
        didSet {
            updateSearch()
        }
    }

    private(set) var page: Int = 1
    private var info: Info?
    private weak var coordinator: CharacterCoordinator?
    private let networkService: CharacterListNetworkServicing

    public init(coordinator: CharacterCoordinator? = nil,
                networkService: CharacterListNetworkServicing) {
        self.coordinator = coordinator
        self.networkService = networkService
    }

    func isCharacterFavorite(character: Character) -> Bool {
        favoriteCharacters.contains(character)
    }

    func onHeartClick(character: Character) {
        if favoriteCharacters.contains(character) {
            favoriteCharacters.remove(character)
        } else {
            favoriteCharacters.insert(character)
        }
    }

    func onClick(character: Character) {
        coordinator?.openDetails(character: character)
    }

    @MainActor
    func onLoadNext() async {
        guard state == .good else {
            return
        }

        state = .isLoading
        await fetchCharacters(page: page)
        page = page + 1
    }

    @MainActor
    private func fetchCharacters(page: Int) async {
        do {
            let fetchedCharacters = try await networkService.fetchCharacters(page: page)
            info = fetchedCharacters.info
            characters.append(contentsOf: fetchedCharacters.results)
            updateSearch()
            state = (info?.next != nil) ? .good : .loadedAll
        } catch {
            guard let error = LocalizedAppError(error: error) else {
                return
            }
            state = .error(error.errorDescription ?? "")
        }
    }

    private func updateSearch() {
        guard searchText.count > 0 else {
            filteredCharacters = characters
            return
        }

        filteredCharacters = characters.filter { character in
            character.name.contains(searchText)
        }
    }
}
