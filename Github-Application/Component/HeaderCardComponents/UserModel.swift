import Foundation

struct UserModelResponse: Decodable {
    let login: String
    let name: String
    let avatarUrl: URL?
    let publicRepos: Int
    let followers: Int
    let following: Int
    let bio: String?
}
