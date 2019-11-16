import Foundation

struct RepositoryModel: Codable {
    let name: String
    let fullName: String
    let description: String
    let ownerName: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let defaultBranch: String
    let openIssuesCount: Int
}
