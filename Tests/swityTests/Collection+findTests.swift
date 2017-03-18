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
        let chars = "Hello World".characters
        var searchChars = "World".characters
        var from = chars.index(after: chars.index(of: " ")!)
        var to = chars.endIndex
        var r = chars.range(of: searchChars, in: from..<to)
        XCTAssertNotNil(r)
        XCTAssertEqual(String(chars[r!]), String(searchChars))

        searchChars = "Hello".characters
        from = chars.index(after: chars.index(of: " ")!)
        to = chars.endIndex
        r = chars.range(of: searchChars, in: from..<to)
        XCTAssertNil(r)
    }
}
