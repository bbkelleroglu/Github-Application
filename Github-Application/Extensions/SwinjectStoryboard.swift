//swiftlint:disable identifier_name
import Foundation
import RestingKit
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc
    class func setup() {
        let container = defaultContainer
        container.autoregister(Config.self, initializer: Config.init)
        registerControllers(container: container)
        #if MOCK
        container.autoregister(RepositoryService.self, initializer: MockGithubSearchService.init)
        #else
        registerNetworkServices(into: container)
        #endif
    }
    static func registerNetworkServices(into container: Container) {
        container.autoregister(NetworkService.self, initializer: NetworkService.init)
        container.autoregister(RepositoryService.self, initializer: GithubSearchService.init).inObjectScope(.container)
        container.autoregister(UserService.self, initializer: GithubUserService.init).inObjectScope(.container)
    }
    static func registerMockServices(into container: Container) {
        container.autoregister(UserService.self, initializer: MockGithubUserService.init).inObjectScope(.container)
        container.autoregister(RepositoryService.self,
                               initializer: MockGithubSearchService.init).inObjectScope(.container)
    }
    static func registerControllers(container: Container) {
        container.storyboardInitCompleted(RepoSearchViewController.self) { r, c in
            c.searchService = r~>
        }
        container.storyboardInitCompleted(UserDetailViewController.self) { r, c in
            c.userService = r~>
            c.userRepositoriesService = r~>
        }
    }
}
