import SwiftUI

public struct TextTitle: View {
    let title: String

    public var body: some View {
        Text(title)
            .font(.title2)
            .foregroundColor(.blue)
            .lineLimit(1)
    }

    public init(title: String) {
        self.title = title
    }
}
