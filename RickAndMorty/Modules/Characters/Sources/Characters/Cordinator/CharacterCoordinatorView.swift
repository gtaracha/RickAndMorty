import SwiftUI

public struct CharacterCoordinatorView: View {
    @ObservedObject var coordinator: CharacterCoordinator

    public var body: some View {
        NavigationView {
            CharacterListView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.detailViewModel) { viewModel in
                    CharacterDetailsView(viewModel: viewModel)
                }
        }
    }

    public init(coordinator: CharacterCoordinator) {
        self.coordinator = coordinator
    }
}

