import XCTest
@testable import Github_Application
class RepositoryPaginateTests: XCTestCase {
    var repositoryPaginate: RepositoryPaginate?
    override func setUp() {
        repositoryPaginate = RepositoryPaginate(page: 1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func paginateTest() {
        XCTAssertEqual(repositoryPaginate?.page, 1)
    }

    func paginateNextTest() {
        XCTAssertEqual(repositoryPaginate?.next.page, 2)
    }

}
