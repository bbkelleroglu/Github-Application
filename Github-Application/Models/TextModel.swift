import Foundation

struct TextModel: PageRequest {
    // swiftlint:disable:next identifier_name
    let q: String
    let page: Int

    var next: TextModel { TextModel(q: q, page: page + 1) }
}
