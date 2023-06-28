import Foundation

public enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}
