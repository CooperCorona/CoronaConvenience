//
//  CGSizeTests.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 4/29/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

import Foundation
import XCTest
#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif
import CoronaConvenience

class CGSize_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        let result = lhs + rhs
        XCTAssert(result.width == 4.0 && result.height == 6.0)
    }
    
    func testSubtract() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        let result = lhs - rhs
        XCTAssert(result.width == -2.0 && result.height == -2.0)
    }
    
    func testMultiply() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        let result = lhs * rhs
        XCTAssert(result.width == 3.0 && result.height == 8.0)
    }
    
    func testDivide() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        let result = lhs / rhs
        XCTAssert(result.width == 1.0 / 3.0 && result.height == 0.5)
    }
    
    func testAddAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        lhs += rhs
        XCTAssert(lhs.width == 4.0 && lhs.height == 6.0)
    }
    
    func testSubtractAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        lhs -= rhs
        XCTAssert(lhs.width == -2.0 && lhs.height == -2.0)
    }
    
    func testMultiplyAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        lhs *= rhs
        XCTAssert(lhs.width == 3.0 && lhs.height == 8.0)
    }
    
    func testDivideAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs = CGSize(width: 3.0, height: 4.0)
        lhs /= rhs
        XCTAssert(lhs.width == 1.0 / 3.0 && lhs.height == 0.5)
    }
    
    func testAddScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGSize(width: 1.0, height: 2.0)
        let result = lhs + rhs
        XCTAssert(result.width == 4.0 && result.height == 5.0)
    }
    
    func testSubtractScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGSize(width: 1.0, height: 2.0)
        let result = lhs - rhs
        XCTAssert(result.width == 2.0 && result.height == 1.0)
    }
    
    func testMultiplyScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGSize(width: 1.0, height: 2.0)
        let result = lhs * rhs
        XCTAssert(result.width == 3.0 && result.height == 6.0)
    }
    
    func testDivideScalarLeft() {
        let lhs:CGFloat = 3.0
        let rhs = CGSize(width: 1.0, height: 2.0)
        let result = lhs / rhs
        XCTAssert(result.width == 3.0 && result.height == 1.5)
    }
    
    func testAddScalarRight() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs + rhs
        XCTAssert(result.width == 4.0 && result.height == 5.0)
    }
    
    func testSubtractScalarRight() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs - rhs
        XCTAssert(result.width == -2.0 && result.height == -1.0)
    }
    
    func testMultiplyScalarRight() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs * rhs
        XCTAssert(result.width == 3.0 && result.height == 6.0)
    }
    
    func testDivideScalarRight() {
        let lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        let result = lhs / rhs
        XCTAssert(result.width == 1.0 / 3.0 && result.height == 2.0 / 3.0)
    }
    
    func testAddScalarAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        lhs += rhs
        XCTAssert(lhs.width == 4.0 && lhs.height == 5.0)
    }
    
    func testSubtractScalarAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        lhs -= rhs
        XCTAssert(lhs.width == -2.0 && lhs.height == -1.0)
    }
    
    func testMultiplyScalarAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        lhs *= rhs
        XCTAssert(lhs.width == 3.0 && lhs.height == 6.0)
    }
    
    func testDivideScalarAssignment() {
        var lhs = CGSize(width: 1.0, height: 2.0)
        let rhs:CGFloat = 3.0
        lhs /= rhs
        XCTAssert(lhs.width == 1.0 / 3.0 && lhs.height == 2.0 / 3.0)
    }
}
