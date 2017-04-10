//
//  BoundingBoxTests.swift
//  Euclid
//
//  Created by Tim Searle on 10/04/2017.
//
//

import XCTest
import CoreLocation

@testable import Euclid

class BoundingBoxTests: XCTestCase {
    
    func testBoundingBox() {
        let lowerLeft = CLLocationCoordinate2DMake(53.403340795473305, -2.3910671181116276)
        let upperRight = CLLocationCoordinate2DMake(53.571349097504395, -2.1086999022056996)
        
        let boundingBox = BoundingBox(lowerLeft: lowerLeft, upperRight: upperRight)
        
        XCTAssertEqual(boundingBox.lowerLeft.latitude, lowerLeft.latitude)
        XCTAssertEqual(boundingBox.lowerLeft.longitude, lowerLeft.longitude)
        XCTAssertEqual(boundingBox.upperRight.latitude, upperRight.latitude)
        XCTAssertEqual(boundingBox.upperRight.longitude, upperRight.longitude)
    }
    
    func testDiagonalDistance() {
        let boundingBox = BoundingBox(lowerLeft: CLLocationCoordinate2DMake(-0.0063591640470713013, -0.0063591640862453083),
                                      upperRight: CLLocationCoordinate2DMake(0.0063591640470713005, 0.0063591640862453083))
        let diagonalDistance = 2000.0
        
        XCTAssertEqualWithAccuracy(boundingBox.diagonal, diagonalDistance, accuracy: 0.0001)
    }

    func testBoundingBoxMidpoint() {
        
        let lowerLeft = CLLocationCoordinate2DMake(53.403340795473305, -2.3910671181116276)
        let upperRight = CLLocationCoordinate2DMake(53.571349097504395, -2.1086999022056996)
        
        let boundingBox = BoundingBox(lowerLeft: lowerLeft, upperRight: upperRight)
        
        let actualMidpoint = CLLocationCoordinate2DMake(53.4875, -2.250278)
        let calculatedMidpoint = boundingBox.midpoint
        
        XCTAssertEqualWithAccuracy(actualMidpoint.latitude, calculatedMidpoint.latitude, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(actualMidpoint.longitude, calculatedMidpoint.longitude, accuracy: 0.01)
    }
    
    func testBoundingBoxExpand() {
        let lowerLeft = CLLocationCoordinate2DMake(53.403340795473305, -2.3910671181116276)
        let upperRight = CLLocationCoordinate2DMake(53.571349097504395, -2.1086999022056996)
        
        let expandedLowerLeft = CLLocationCoordinate2DMake(53.396981156263728, -2.4017320756211551)
        let expandedUpperRight = CLLocationCoordinate2DMake(53.577707783323063, -2.0979894065098326)
        
        let boundingBox = BoundingBox(lowerLeft: lowerLeft, upperRight: upperRight)
        let expandedBoundingBox = boundingBox.expand(by: 1000)
        
        XCTAssertEqual(expandedBoundingBox.lowerLeft.latitude, expandedLowerLeft.latitude)
        XCTAssertEqual(expandedBoundingBox.lowerLeft.longitude, expandedLowerLeft.longitude)
        XCTAssertEqual(expandedBoundingBox.upperRight.latitude, expandedUpperRight.latitude)
        XCTAssertEqual(expandedBoundingBox.upperRight.longitude, expandedUpperRight.longitude)
    }
    
    func testBoundingBoxShrink() {
        let lowerLeft = CLLocationCoordinate2DMake(53.396981156263728, -2.4017320756211551)
        let upperRight = CLLocationCoordinate2DMake(53.577707783323063, -2.0979894065098326)
        
        let shrunkLowerLeft = CLLocationCoordinate2DMake(53.403340795473305, -2.3910671181116276)
        let shrunkUpperRight = CLLocationCoordinate2DMake(53.571349097504395, -2.1086999022056996)
        
        let boundingBox = BoundingBox(lowerLeft: lowerLeft, upperRight: upperRight)
        let shrunkBoundingBox = boundingBox.shrink(by: 1000)
        
        XCTAssertEqualWithAccuracy(shrunkBoundingBox.lowerLeft.latitude, shrunkLowerLeft.latitude, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(shrunkBoundingBox.lowerLeft.longitude, shrunkLowerLeft.longitude, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(shrunkBoundingBox.upperRight.latitude, shrunkUpperRight.latitude, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(shrunkBoundingBox.upperRight.longitude, shrunkUpperRight.longitude, accuracy: 0.01)
    }
    
    func testBoundingBoxContainsCoordinate() {
        let lowerLeft = CLLocationCoordinate2DMake(53.396981156263728, -2.4017320756211551)
        let upperRight = CLLocationCoordinate2DMake(53.577707783323063, -2.0979894065098326)
        
        let boundingBox = BoundingBox(lowerLeft: lowerLeft, upperRight: upperRight)
        
        let insideCoordinate = CLLocationCoordinate2DMake(53.487440724557665, -2.2501842879482532)
        let outsideCoordinate = CLLocationCoordinate2DMake(14.2350, 51.9253)
        
        XCTAssertFalse(boundingBox.contains(coordinate: outsideCoordinate))
        XCTAssertTrue(boundingBox.contains(coordinate: insideCoordinate))
    }
}
