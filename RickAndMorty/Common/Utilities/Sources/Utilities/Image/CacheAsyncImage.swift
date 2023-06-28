import SwiftUI

public struct CacheAsyncImage: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction

    public init?(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction()
    ){
        guard let url else { return nil }
        self.url = url
        self.scale = scale
        self.transaction = transaction
    }

    public var body: some View {
        if let cached = ImageCache[url] {
            cached.resizable()
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    storeImage(image: image).resizable()
                case .failure:
                    Color.gray
                @unknown default:
                    EmptyView()
                }
            }
        }
    }

    func storeImage(image: Image) -> Image {
        ImageCache[url] = image
        return image
    }
}

fileprivate class ImageCache{
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
