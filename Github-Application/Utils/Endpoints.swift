import Foundation
import RestingKit
enum Endpoints {
    enum Repository {
        static let search = Endpoint<TextModel, RepositoryResponseModel>(.get, "/search/repositories", encoding: .query)
    }
    enum Users {
        static let userDetail = Endpoint<Nothing, UserModelResponse>(.get, "/users/{{username}}", encoding: .query)
    }
}
