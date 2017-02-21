//
//  Collection+findTests.swift
//  swity-elements
//
//  Created by Kosuke Yoshimoto on 2017/02/19
//  Copyright © 2017 ysn551 All rights reserved.
//

import XCTest
import Foundation
@testable import swity

class CollectionFindsTests: XCTestCase {
    func testCharactersSearch() {
        let str = "Hello World"
        var r = str.characters.range(of: "World".characters)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "World")

        r = str.characters.range(of: "".characters)
        XCTAssertNil(r)

        r = str.characters.range(of: "H".characters)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "H")

        r = str.characters.range(of: "He".characters)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "He")

        r = str.characters.range(of: "Hel".characters)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "Hel")

        r = str.characters.range(of: "Hello ".characters)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "Hello ")

        r = str.characters.range(of: "Word".characters)
        XCTAssertNil(r)

        r = str.characters.range(of: "Hello World!".characters)
        XCTAssertNil(r)
    }

    func testSubCharacterSearch() {
        let str = "✒ 🍍 🍎 ✑"
        var searchRange = str.startIndex..<str.startIndex
        var r = str.characters.range(of: "🍎".characters, in: searchRange)
        XCTAssertNil(r)

        searchRange = str.startIndex..<str.index(after: str.startIndex)
        r = str.characters.range(of: "✒".characters, in: searchRange)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "✒")

        searchRange = str.index(after: str.startIndex)..<str.index(str.startIndex, offsetBy: str.characters.count - 2)
        r = str.characters.range(of: "✒".characters, in: searchRange)
        XCTAssertNil(r)

        searchRange = str.index(after: str.startIndex)..<str.index(str.startIndex, offsetBy: str.characters.count - 3)
        r = str.characters.range(of: "✑".characters, in: searchRange)
        XCTAssertNil(r)

        r = str.characters.range(of: "🍍".characters, in: searchRange)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "🍍")

        r = str.characters.range(of: "🍎".characters, in: searchRange)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "🍎")

        searchRange = str.index(before: str.endIndex)..<str.endIndex
        r = str.characters.range(of: "✑".characters, in: searchRange)
        XCTAssertNotNil(r)
        XCTAssertEqual(str[r!], "✑")
    }
}
