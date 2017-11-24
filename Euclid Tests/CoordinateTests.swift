//
//  CoordinateTests.swift
//  CoordinateTests
//
//  Created by Tim Searle on 10/12/2016.
//
//

import XCTest
import CoreLocation

@testable import Euclid

class CoordinateTests: XCTestCase {
    
    func testDistanceBetweenCoordinates() {
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let test1000 = source.distance(to: destination)
        let testTranspose1000 = destination.distance(to: source)
    
        XCTAssertEqual(test1000, 100000, accuracy: 20, "Expected distance is ~100,000 metres")
        XCTAssertTrue(test1000 == testTranspose1000 , "Swapping sender and receiver should not cause different results")
    }
    
    func testBearingToCoordinate() {
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let bearing = source.bearing(to: destination)
        
        XCTAssertEqual(bearing, -89.424, accuracy: 0.1, "Expected bearing is ~-89.424")
    }
    
    func testCompassBearingToCoordinate() {
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let bearing = source.compassBearing(to: destination)
        
        XCTAssertEqual(bearing, 270, accuracy: 0.75, "Expected bearing is ~270")
    }
    
    func testDestinationCoordinateForCompassBearing() {
        
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let compassBearing = source.compassBearing(to: destination)
        
        let calculatedDestination = Euclid.destination(start: source, distance: 100000, compassBearing: compassBearing)
        
        XCTAssertEqual(calculatedDestination.latitude, destination.latitude, accuracy: 0.01)
        XCTAssertEqual(calculatedDestination.longitude, destination.longitude, accuracy: 0.01)
    }
    
    func testDestinationCoordinateForBearing() {
        
        let source = CLLocationCoordinate2D(latitude: 52.0, longitude: -0.0)
        let destination = CLLocationCoordinate2D(latitude: 52.0, longitude: -1.461)
        
        let bearing = source.bearing(to: destination)
        
        let calculatedDestination = Euclid.destination(start: source, distance: 100000, bearing: bearing)
        
        XCTAssertEqual(calculatedDestination.latitude, destination.latitude, accuracy: 0.01)
        XCTAssertEqual(calculatedDestination.longitude, destination.longitude, accuracy: 0.01)
    }
    
    func testMidpointBetweenCoordinates() {
        let source = CLLocationCoordinate2DMake(53.403340795473305, -2.3910671181116276)
        let destination = CLLocationCoordinate2DMake(53.571349097504395, -2.1086999022056996)
        let actualMidpoint = CLLocationCoordinate2DMake(53.4875, -2.250278)
        
        let calcuatedMidpoint = source.midpoint(between: destination)
        
        XCTAssertEqual(calcuatedMidpoint.latitude, actualMidpoint.latitude, accuracy: 0.001)
        XCTAssertEqual(calcuatedMidpoint.longitude, actualMidpoint.longitude, accuracy: 0.001)
    }
    
    func testRadianConversion() {
        let degrees = CLLocationDegrees(360)
        let radians = degrees.toRadians()
        XCTAssertEqual(radians, 6.28319, accuracy: 0.01 ,"Expected radians is ~6.28319")
    }
    
    func testDegreeConversion() {
        let radians = 1.0
        let degrees = radians.toDegrees()
        XCTAssertEqual(degrees, 57.2958, accuracy: 0.01 ,"Expected degrees is ~57.2958")
    }

}
