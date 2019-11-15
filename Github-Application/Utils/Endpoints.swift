import Foundation
import RestingKit
enum Endpoints {
    enum Repository {
        static let search = Endpoint<TextModel,[RepositoryModel]>(.get, "/search/repositories",encoding: .query)
    }
}
