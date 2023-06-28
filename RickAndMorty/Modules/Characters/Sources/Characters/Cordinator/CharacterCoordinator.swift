import Foundation
import Networking
import SwiftUI

public class CharacterCoordinator: ObservableObject {

    // MARK: Stored Properties

    @Published var viewModel: CharacterListViewModel!
    @Published var detailViewModel: CharacterDetailsViewModel?

    // MARK: Initialization

    public init() {
        self.viewModel = .init(coordinator: self, networkService: CharacterListNetworkService(client: URLSessionClient()))
    }

    // MARK: Methods

    func openDetails(character: Character) {
        detailViewModel = CharacterDetailsViewModel(character: character)
    }

}
