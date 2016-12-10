//
//  Euclid_Tests.swift
//  Euclid Tests
//
//  Created by Tim Searle on 10/12/2016.
//
//

import XCTest
import CoreLocation

@testable import Euclid

class Euclid_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDistanceBetweenCoordinates() {
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let test1000 = source.distance(from: destination)
        let testTranspose1000 = destination.distance(from: source)
    
        XCTAssertEqualWithAccuracy(test1000, 100000, accuracy: 20, "Expected distance is ~100,000 metres")
        XCTAssertTrue(test1000 == testTranspose1000 , "Swapping sender and receiver should not cause different results")
    }
    
    func testBearingToCoordinate() {
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let bearing = source.bearing(to: destination)
        
        XCTAssertEqualWithAccuracy(bearing, -89.424, accuracy: 0.1, "Expected bearing is ~-89.424")
    }
    
    func testCompassBearingToCoordinate() {
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let bearing = source.compassBearing(to: destination)
        
        XCTAssertEqualWithAccuracy(bearing, 270, accuracy: 0.75, "Expected bearing is ~270")
    }
    
    func testDestinationCoordinateForCompassBearing() {
        // TODO
    }
    
    func testDestinationCoordinateForBearing() {
        // TODO
    }
    
    func testRadianConversion() {
        let degrees = CLLocationDegrees(360)
        let radians = degrees.toRadians()
        XCTAssertEqualWithAccuracy(radians, 6.28319, accuracy: 0.01 ,"Expected radian is ~6.28319")
    }
}
