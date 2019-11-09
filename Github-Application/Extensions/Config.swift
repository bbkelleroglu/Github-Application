import Foundation
import RestingKit

class Config {
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
    let queryParameterEncoder = QueryParameterEncoder()
    let baseUrl: String

    init() {
        baseUrl = "https://api.github.com"
        jsonEncoder.dateEncodingStrategy = .iso8601
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase

        queryParameterEncoder.dateEncodingStrategy = .iso8601(ISO8601DateFormatter())
        queryParameterEncoder.keyEncodingStrategy = .convertToSnakeCase

        let dateTimeFormatter = ISO8601DateFormatter()
        dateTimeFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            guard let date = dateTimeFormatter.date(from: string) else {
                let context = EncodingError.Context(codingPath: container.codingPath,
                                                    debugDescription: "Expected '\(string)` to be a date")
                throw EncodingError.invalidValue(string, context)
            }
            return date
        }
    }
}
