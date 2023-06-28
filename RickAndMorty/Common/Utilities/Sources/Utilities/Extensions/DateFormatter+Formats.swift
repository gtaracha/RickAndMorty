import Foundation

public extension DateFormatter {
    enum DateFormat: String {
        case yearMonthDay = "yyyy-MM-dd"
        case dayMonthYear = "dd.MM.yyyy"
        case dayMonthYearHoursMinutes = "dd.MM.yyyy HH:mm"
    }

    convenience init(with format: DateFormat) {
        self.init()
        self.dateFormat = format.rawValue
    }
}
