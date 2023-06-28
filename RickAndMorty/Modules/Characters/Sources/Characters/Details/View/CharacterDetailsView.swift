import SwiftUI
import Utilities

public struct CharacterDetailsView: View {
    @ObservedObject var viewModel: CharacterDetailsViewModel
    let imageHeight: CGFloat = 350
    let infoBoxWidth: CGFloat = 300

    public init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack {
                CacheAsyncImage(url: URL(string: viewModel.character.image)!)
                    .scaledToFill()
                    .frame( height: imageHeight)
                    .clipped()

                Text(viewModel.character.name)
                    .font(.title)
                    .padding()


                VStack(alignment: .leading, spacing:  10) {

                    DetailsRowView(title: "Status:", value: viewModel.character.status)

                    DetailsRowView(title: "Species:", value: viewModel.character.species)

                    if viewModel.character.type.count > 0 {
                        DetailsRowView(title: "Type:", value: viewModel.character.type)
                    }

                    DetailsRowView(title: "Gender:", value: viewModel.character.gender)

                    DetailsRowView(title: "Origin:", value: viewModel.character.origin.name)

                    DetailsRowView(title: "Location:", value: viewModel.character.location.name)

                    DetailsRowView(title: "Number of episodes:", value: "\(viewModel.character.episode.count)")

                }
                .frame(width: infoBoxWidth)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct DetailsRowView: View {
    let title: String
    let value: String

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
                .font(.headline)
        }
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: ExampleCharacter.example1))
    }
}
