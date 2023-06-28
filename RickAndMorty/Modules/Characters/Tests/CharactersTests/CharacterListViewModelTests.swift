import XCTest
@testable import Characters
@testable import Utilities

class CharacterListViewModelTests: XCTestCase {
    private let networkService = MockCharacterListNetworkService()
    private var viewModel: CharacterListViewModel!

    override func setUp() {
        self.viewModel = CharacterListViewModel(networkService: networkService)
    }

    override func tearDown() {
        self.viewModel = nil
    }

    func test_returns_correct_initial_page() {
        let expectedValue = 1
        let actualValue = viewModel.page

        XCTAssertEqual(expectedValue, actualValue)
    }

    func test_returns_correct_initial_state() {
        let expectedValue = FetchState.good
        let actualValue = viewModel.state

        XCTAssertEqual(expectedValue, actualValue)
    }

    func test_returns_correct_initial_characters() {
        XCTAssertEqual(viewModel.characters, [])
        XCTAssertEqual(viewModel.filteredCharacters, [])
        XCTAssertEqual(viewModel.favoriteCharacters, [])
    }

    func test_returns_correct_fetched_characters_count_page1_count() async {
        await viewModel.onLoadNext()

        let expectedValue = 22
        let actualValue = viewModel.characters.count

        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(viewModel.state, FetchState.good)
    }

    func test_returns_correct_fetched_characters_count_page2_count() async {
        await viewModel.onLoadNext()
        await viewModel.onLoadNext()

        let expectedValue = 44
        let actualValue = viewModel.characters.count

        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(viewModel.state, FetchState.loadedAll)
    }

    func test_returns_correct_fetched_characters_mapping() async {
        await viewModel.onLoadNext()

        let expectedValue = "Rick Sanche"
        let actualValue = viewModel.characters.first?.name

        XCTAssertEqual(expectedValue, actualValue)
    }

    func test_returns_correct_search_characters() async {
        await viewModel.onLoadNext()
        viewModel.searchText = "Mort"

        var expectedValue = "Morty Smith"
        var actualValue = viewModel.filteredCharacters.first?.name
        XCTAssertEqual(expectedValue, actualValue)

        viewModel.searchText = "Sanche"
        expectedValue = "Rick Sanche"
        actualValue = viewModel.filteredCharacters.first?.name
        XCTAssertEqual(expectedValue, actualValue)
    }

    func test_add_to_favorites_and_remove_character() async {
        await viewModel.onLoadNext()

        guard let character = viewModel.filteredCharacters.first else {
            XCTFail("Expected non-nil character")
            return
        }
        viewModel.onHeartClick(character: character)

        let expectedValue = character
        var actualValue = viewModel.favoriteCharacters.first
        XCTAssertEqual(expectedValue, actualValue)

        viewModel.onHeartClick(character: character)

        actualValue = viewModel.favoriteCharacters.first
        XCTAssertNil(actualValue)
    }
}
