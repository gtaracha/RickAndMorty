import SwiftUI
import Characters

@main
struct RickAndMortyApp: App {
    // MARK: Stored Properties

    @StateObject var coordinator = CharacterCoordinator()

    // MARK: Scenes

    var body: some Scene {
        WindowGroup {
            CharacterCoordinatorView(coordinator: coordinator)
        }
    }
}
