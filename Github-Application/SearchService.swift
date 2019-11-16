import Foundation
import PromiseKit
import RestingKit
protocol SearchService {
    func searchRepo(text: String) -> Promise<[RepositoryModel]>
}

class GithubSearchService: SearchService {
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
}

class MockGithubSearchService: SearchService {
    private let fixtures: Fixtures

    init(fixtures: Fixtures) {
        self.fixtures = fixtures
    }
    func searchRepo(text: String) -> Promise<[RepositoryModel]> {
        return Promise.value(fixtures.repository)
    }
}
