import SwiftUI
import Utilities
import Networking

public struct CharacterListView: View {
    @ObservedObject private var viewModel: CharacterListViewModel

    public var body: some View {
        TabView {
            listOfCharacters
                .tabItem {
                    Label("All", systemImage: "person.crop.rectangle.stack.fill")
                }

            listOfFavoritesCharacters
                .tabItem {
                    Label("Favorites", systemImage: "heart.circle.fill")
                }
        }
    }

    private var listOfCharacters: some View {
        VStack {
            searchBar
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.filteredCharacters) { character in
                        CharacterCell(character: character,
                                      isFavorite: viewModel.isCharacterFavorite(character: character)) {
                            viewModel.onHeartClick(character: character)
                        }
                        .onNavigation {
                            viewModel.onClick(character: character)
                        }
                    }

                    switch viewModel.state {
                    case .good:
                        Color.clear
                            .onAppear {
                                Task {
                                    await viewModel.onLoadNext()
                                }
                            }
                    case .isLoading:
                        ProgressView("Loading")
                    case .loadedAll:
                        EmptyView()
                    case .error(let errorDescription):
                        Text(errorDescription)
                            .padding()
                    }
                }
            }.clipped()
        }
    }

    private var listOfFavoritesCharacters: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.favoriteCharacters.sorted(by: <), id: \.id) { character in
                    CharacterCell(character: character,isFavorite: viewModel.isCharacterFavorite(character: character)) {
                        viewModel.onHeartClick(character: character)
                    }
                    .onNavigation {
                        viewModel.onClick(character: character)
                    }
                }
            }
        }.clipped()
    }

    private var searchBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 23, weight: .regular))
                .foregroundColor(.gray)
            TextField("Search", text: $viewModel.searchText)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.primary.opacity(0.05))
        .cornerRadius(8)
        .padding()
    }

    public init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
}

