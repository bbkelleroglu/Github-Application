import XCTest
@testable import Github_Application

class NumberUtilsTest: XCTestCase {
    func testSmallNumber() {
        let number = NumberUtils.formatWithUnits(10)
        XCTAssertEqual(number, "10")

    }

    func testMillion() {
        let million = NumberUtils.formatWithUnits(1_000_000)
        XCTAssertEqual(million, "1M")
    }

    func testThousands() {
        let million = NumberUtils.formatWithUnits(1_000)
        XCTAssertEqual(million, "1K")
    }

    func testBillions() {
        let million = NumberUtils.formatWithUnits(1_000_000_000)
        XCTAssertEqual(million, "1B")
    }

}
