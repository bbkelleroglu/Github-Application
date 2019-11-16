import Foundation
import RestingKit
enum Endpoints {
    enum Repository {
        static let search = Endpoint<TextModel, RepositoryResponseModel>(.get, "/search/repositories", encoding: .query)
    }
}
