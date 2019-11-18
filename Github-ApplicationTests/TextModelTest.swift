import XCTest
@testable import Github_Application

class TextModelTest: XCTestCase {
    var textModel: TextModel?
    override func setUp() {
        textModel = TextModel(q: "swift", page: 1)
    }

    override func tearDown() {
       textModel = nil
    }

    func textModelTest() {
        XCTAssertEqual(textModel?.next.page, 2)
        XCTAssertEqual(textModel?.next.q, textModel?.q)
    }
}
