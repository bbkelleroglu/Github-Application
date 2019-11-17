import Foundation
import PromiseKit
import RestingKit
protocol UserService {
    func userDetail(username: String) -> Promise<UserModelResponse>
}
class GithubUserService: UserService {
    private let networkService: NetworkService!

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func userDetail(username: String) -> Promise <UserModelResponse> {
        let request = RestingRequest(endpoint: Endpoints.Users.userDetail,
                                     body: Nothing(),
                                     pathVariables: ["username": username])
        return networkService.httpCall().perform(request).extractingBody()
    }
}

class MockGithubUserService: UserService {
    private let fixtures: Fixtures

    init(fixtures: Fixtures) {
        self.fixtures = fixtures
    }

    func userDetail(username: String) -> Promise<UserModelResponse> {
        return Promise.value(fixtures.userDetail)
    }
}
