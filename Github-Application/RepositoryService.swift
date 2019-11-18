import Foundation
import PromiseKit
import RestingKit
protocol RepositoryService {
    func searchRepo(body: TextModel) -> Promise<Page<RepositoryModel, TextModel>>
    func userRepositoryService(username: String, body: RepositoryPaginate) -> Promise<Page<RepositoryModel, RepositoryPaginate>>
}

class GithubSearchService: RepositoryService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func searchRepo(body: TextModel) -> Promise<Page<RepositoryModel, TextModel>> {
        let request = RestingRequest(endpoint: Endpoints.Repository.search, body: body)
        return networkService.httpCall().perform(request).map {
            Page(data: $0.body.items, request: body)
        }
    }

    func userRepositoryService(username: String, body: RepositoryPaginate) -> Promise<Page<RepositoryModel, RepositoryPaginate>> {
        let request = RestingRequest(endpoint: Endpoints.Users.userRepositoryDetail,
                                     body: body,
                                     pathVariables: ["username": username])
        return networkService.httpCall().perform(request).map {
            $0.body
        }.toPage(with: body)
    }
}

class MockGithubSearchService: RepositoryService {
    private let fixtures: Fixtures

    init(fixtures: Fixtures) {
        self.fixtures = fixtures
    }
    func searchRepo(body: TextModel) -> Promise<Page<RepositoryModel, TextModel>> {
        return Promise.value(fixtures.repository).map {
            Page(data: $0, request: body)
        }
    }

    func userRepositoryService(username: String, body: RepositoryPaginate) -> Promise<Page<RepositoryModel, RepositoryPaginate>> {
        return Promise.value(fixtures.repository).toPage(with: body)
    }
}
