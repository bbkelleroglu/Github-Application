import Foundation

struct RepositoryModel: Codable {
    let id: Int
    let fullName: String
    let description: String?
    let owner: Owner
    let stargazersCount: Int
    let language: String?
}

struct RepositoryResponseModel: Decodable {
    let items: [RepositoryModel]
}
struct Owner: Codable {
    let avatarUrl: URL?
}
