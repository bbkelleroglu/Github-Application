import Foundation

extension Date {
   static func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        let strMonth = dateFormatter.string(from: date)
        return strMonth
    }
}
