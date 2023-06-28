import SwiftUI
import Utilities

struct CharacterCell: View {
    let character: Character
    var isFavorite: Bool
    let onButtonClick: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            CacheAsyncImage(url: URL(string: character.image))
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 5) {
                TextTitle(title: character.name)
                TextSubtitle(subtitle: "\(character.species), \(character.status)")
            }

            Spacer()

            Button {
                onButtonClick()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
        }.padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: ExampleCharacter.example1, isFavorite: false) {
        }
    }
}

