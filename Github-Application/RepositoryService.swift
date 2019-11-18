import Foundation
import PromiseKit
import RestingKit
protocol RepositoryService {
    func searchRepo(text: String) -> Promise<[RepositoryModel]>
    func userRepositoryService(username: String) -> Promise<[RepositoryModel]>
}

class GithubSearchService: RepositoryService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func searchRepo(text: String) -> Promise<[RepositoryModel]> {
        let request = RestingRequest(endpoint: Endpoints.Repository.search, body: TextModel(q: text))
        return networkService.httpCall().perform(request).map {
            $0.body.items
        }
    }
    func userRepositoryService(username: String) -> Promise<[RepositoryModel]> {
        let request = RestingRequest(endpoint: Endpoints.Users.userRepositoryDetail,
                                     body: Nothing(),
                                     pathVariables: ["username": username])
        return networkService.httpCall().perform(request).extractingBody()
    }
}

class MockGithubSearchService: RepositoryService {
    private let fixtures: Fixtures

    init(fixtures: Fixtures) {
        self.fixtures = fixtures
    }
    func searchRepo(text: String) -> Promise<[RepositoryModel]> {
        return Promise.value(fixtures.repository)
    }
    func userRepositoryService(username: String) -> Promise<[RepositoryModel]> {
        return Promise.value(fixtures.repository)
    }
}
