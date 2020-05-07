import XCTest
import NaturalSort

@inline(__always)
func assertAscending(_ expression: @autoclosure () throws -> Bool, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
	XCTAssertTrue(try expression(), message(), file: file, line: line)
}

@inline(__always)
func assertDescending(_ expression: @autoclosure () throws -> Bool, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
	XCTAssertFalse(try expression(), message(), file: file, line: line)
}

final class NaturalSortTests: XCTestCase {
	static var allTests = [
		("testBasicSort", testBasicSort),
		("testRemoveThe", testRemoveThe),
		("testRemoveAn", testRemoveAn),
		("testRemoveA", testRemoveA),
		("testCaseInsensitive", testCaseInsensitive),
		("testNumbers", testNumbers)
	]
	
	func testBasicSort() {
		assertAscending("a".naturalCompare(to: "b"))
		assertDescending("b".naturalCompare(to: "a"))
	}
	
	func testRemoveThe() {
		assertAscending("the best".naturalCompare(to: "canadian"))
		assertDescending("canadian".naturalCompare(to: "best"))
	}
	
	func testRemoveAn() {
		assertAscending("baa".naturalCompare(to: "best"))
		assertDescending("an best".naturalCompare(to: "baa"))
		assertDescending("an canadian".naturalCompare(to: "baa"))
	}
	
	func testRemoveA() {
		assertAscending("baa".naturalCompare(to: "best"))
		assertDescending("a best".naturalCompare(to: "baa"))
		assertDescending("a canadian".naturalCompare(to: "baa"))
	}
	
	func testCaseInsensitive() {
		assertAscending("tHe best".naturalCompare(to: "canadian"))
		assertDescending("canadian".naturalCompare(to: "best"))
	}
	
	func testNumbers() {
		assertAscending("Heinz 47 flavors".naturalCompare(to: "HEINZ 500 FLAVORS"))
		assertDescending("Heinz 47 flavors".naturalCompare(to: "heinz 5 flavors"))
	}
}
