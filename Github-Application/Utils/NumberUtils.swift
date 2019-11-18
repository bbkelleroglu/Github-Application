import Foundation
class NumberUtils {
    private init() { }

    private static let rankFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()

    static func formatWithUnits(_ value: Int) -> String {
        let unit: String
        let divider: Int

        switch value {
        case ..<1000:
            unit = ""
            divider = 1
        case 1000..<1_000_000:
            unit = "K"
            divider = 1000
        case 1_000_000..<1_000_000_000:
            unit = "M"
            divider = 1_000_000
        default:
            unit = "B"
            divider = 1_000_000_000
        }

        return rankFormatter.string(from: NSNumber(value: value / divider))! + unit
    }
}
