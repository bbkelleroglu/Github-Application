import Foundation

struct RepositoryModel: Codable {
    let id: Int
    let fullName: String
    let description: String?
    let avatarUrl: URL?
    let stargazersCount: Int
    let language: String?
}

struct RepositoryResponseModel: Decodable {
    let items: [RepositoryModel]
}
