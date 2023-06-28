import Foundation

public extension Date {
    func stringFromDate(with dateFormat: DateFormatter.DateFormat) -> String {
        return DateFormatter(with: dateFormat).string(from: self)
    }
}
