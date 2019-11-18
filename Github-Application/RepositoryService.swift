import Foundation
import PromiseKit
import RestingKit
protocol RepositoryService {
    func searchRepo(body: TextModel) -> Promise<RepositoryPageModel>
    func userRepositoryService(username: String, body: RepositoryPaginate) -> Promise<Page<RepositoryModel, RepositoryPaginate>>
}

class GithubSearchService: RepositoryService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func searchRepo(body: TextModel) -> Promise<RepositoryPageModel> {
        let request = RestingRequest(endpoint: Endpoints.Repository.search, body: body)
        return networkService.httpCall().perform(request).extractingBody().map {
            RepositoryPageModel(page: Page(data: $0.items, request: body), totalCount: $0.totalCount)
        }
    }

    func userRepositoryService(username: String, body: RepositoryPaginate) -> Promise<Page<RepositoryModel, RepositoryPaginate>> {
        let request = RestingRequest(endpoint: Endpoints.Users.userRepositoryDetail,
                                     body: body,
                                     pathVariables: ["username": username])
        return networkService.httpCall().perform(request).extractingBody().toPage(with: body)
    }
}

class MockGithubSearchService: RepositoryService {
    private let fixtures: Fixtures

    init(fixtures: Fixtures) {
        self.fixtures = fixtures
    }
    func searchRepo(body: TextModel) -> Promise<RepositoryPageModel> {
        return Promise.value(fixtures.repository).toPage(with: body).map {
            RepositoryPageModel(page: $0, totalCount: 10)
        }
    }

    func userRepositoryService(username: String, body: RepositoryPaginate) -> Promise<Page<RepositoryModel, RepositoryPaginate>> {
        return Promise.value(fixtures.repository).toPage(with: body)
    }
}
