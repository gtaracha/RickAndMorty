import SwiftUI

public struct TextSubtitle: View {
    let subtitle: String

    public var body: some View {
        Text(subtitle)
            .foregroundColor(.secondary)
            .lineLimit(2)
    }

    public init(subtitle: String) {
        self.subtitle = subtitle
    }
}
