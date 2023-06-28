import Foundation

extension Bundle {
    public enum BundleError: Error {
        case noFileError(String)
    }

    public func loadData(from file: String) throws -> Data {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw BundleError.noFileError(file)
        }

        return try Data(contentsOf: url)
    }
}
