import Foundation

struct RepositoryModel: Codable {
    let id: Int
    let fullName: String
    let description: String?
    let owner: Owner
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let language: String?
}

struct RepositoryResponseModel: Decodable {
    let items: [RepositoryModel]
}
struct Owner: Codable {
    let avatarUrl: URL?
    let login: String
}

struct RepositoryPaginate: PageRequest {
    let page: Int
    var next: RepositoryPaginate { RepositoryPaginate(page: page + 1) }
}
