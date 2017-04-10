//
//  Euclid.swift
//  Euclid
//
//  Created by Tim Searle on 10/12/2016.
//
//

import Foundation
import CoreLocation

public typealias Radians = Double
public typealias Bearing = Double

/// BoundingBox comprised of a lower left and upper right coordinate space
///
///     let lowerLeft: Double
///     let upperRight: Double
///
///     public func expand(by distance: Double) -> BoundingBox
///     public func shrink(by distance: Double) -> BoundingBox
public struct BoundingBox {
    public let lowerLeft: CLLocationCoordinate2D
    public let upperRight: CLLocationCoordinate2D
    
    /// Returns a CLLocationDistance representing the distance between the lowerLeft and upperRight coordinates.
    public let diagonal: CLLocationDistance
    
    /// Returns a CLLocationCoordinate2D representing the centre of the bounding box
    public let center: CLLocationCoordinate2D
    
    public init(lowerLeft: CLLocationCoordinate2D, upperRight: CLLocationCoordinate2D) {
        self.lowerLeft = lowerLeft
        self.upperRight = upperRight
        self.diagonal = self.lowerLeft.distance(to: self.upperRight)
        self.center = Euclid.destination(start: self.lowerLeft, distance: self.diagonal / 2, compassBearing: self.lowerLeft.bearing(to: self.upperRight))
    }
    
    /// Return a new bounding box by expanding the receiver by the specified distance in metres
    ///
    /// - Parameters:
    ///   - distance: Distance in metres to increase the bounding box by. Negative value will return an invalid BoundingBox.
    /// - Returns: A new bounding box
    public func expand(by distance: Double) -> BoundingBox {
        let adjustedLowerLeft = Euclid.destination(start: self.lowerLeft, distance: distance, compassBearing: 225)
        let adjustedUpperRight = Euclid.destination(start: self.upperRight, distance: distance, compassBearing: 45)
        
        return BoundingBox(lowerLeft: adjustedLowerLeft, upperRight: adjustedUpperRight)
    }
    
    /// Return a new bounding box by shrinking the receiver by the specified distance in metres
    ///
    /// - Parameters:
    ///   - distance: Distance in metres to increase the bounding box by. Negative value will return an invalid BoundingBox.
    /// - Returns: A new bounding box
    public func shrink(by distance: Double) -> BoundingBox {
        let adjustedLowerLeft = Euclid.destination(start: self.lowerLeft, distance: distance, compassBearing: 45)
        let adjustedUpperRight = Euclid.destination(start: self.upperRight, distance: distance, compassBearing: 225)
        
        return BoundingBox(lowerLeft: adjustedLowerLeft, upperRight: adjustedUpperRight)
    }
}

/// Euclid - Utility framework for dealing with Great Circle mathematics.
public class Euclid {
    
    public static let kEarthRadiusMetres = 6371e3
    
    /// Destination point given distance and bearing from start point
    ///
    /// - Parameters:
    ///   - start: Initial location given as CLLocationCoordinate2D
    ///   - distance: Distance from start point in metres
    ///   - bearing: Bearing given as value in range -180.0 - 180.0
    /// - Returns: A destination CLLocationCoordinate2D calculated based on the parameters passed
    public static func destination(start: CLLocationCoordinate2D, distance: CLLocationDistance, bearing: Bearing) -> CLLocationCoordinate2D {
        let compassBearing = (bearing.toRadians() + (2 * M_PI)).toDegrees()
        
        return destination(start: start, distance: distance, compassBearing: compassBearing)
    }
    
    /// Destination point given distance and compass bearing from start point
    ///
    /// - Parameters:
    ///   - start: Initial location given as CLLocationCoordinate2D
    ///   - distance: Distance from start point in metres
    ///   - compassBearing: Compass bearing given as value in range 0 - 360 degrees, relative to North
    /// - Returns: A destination CLLocationCoordinate2D calculated based on the parameters passed
    public static func destination(start: CLLocationCoordinate2D, distance: CLLocationDistance, compassBearing: CLLocationDirection) -> CLLocationCoordinate2D {
        
        let angularDistance = (distance / kEarthRadiusMetres)
        let bearingRads = (compassBearing).toRadians()
        
        let startLatitudeRads = start.latitude.toRadians()
        let startLongitudeRads = start.longitude.toRadians()
        
        let destinationLatitude = asin(sin(startLatitudeRads) * cos(angularDistance) + cos(startLatitudeRads) * sin(angularDistance) * cos(bearingRads));
        var destinationLongitude = startLongitudeRads + atan2(sin(bearingRads) * sin(angularDistance) * cos(startLatitudeRads), cos(angularDistance) - sin(startLatitudeRads) * sin(destinationLatitude));
        destinationLongitude = destinationLongitude + (3 * M_PI).truncatingRemainder(dividingBy: (2 * M_PI)) - M_PI;
        
        return CLLocationCoordinate2D(latitude: destinationLatitude.toDegrees(), longitude: destinationLongitude.toDegrees())
    }
}

public extension Radians {
    
    /// Convert radians to degrees
    ///
    /// - Returns: The receiver's value converted to degrees
    public func toDegrees() -> CLLocationDegrees {
        return self / (M_PI / 180)
    }
}

public extension CLLocationDegrees {
    
    /// Convert degrees to radians
    ///
    /// - Returns: The receiver's value converted to radians
    public func toRadians() -> Radians {
        return self * (M_PI / 180)
    }
}

public extension CLLocationCoordinate2D {
    
    /// Distance in metres between receiver and CLLocationCoordinate2D passed as an argument
    ///
    /// - Parameter coordinate: Target CLLocationCoordinate2D to measure the distance to
    /// - Returns: CLLocationDistance representing the distance metres
    public func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        
        let latitudeSource = self.latitude
        let longitudeSource = self.longitude
        let latitudeDestination = coordinate.latitude
        let longitudeDestination = coordinate.longitude
        
        let latitudeSourceRads = latitudeSource.toRadians()
        let latitudeDestinationRads = latitudeDestination.toRadians()
        
        let latitudeDeltaRads = (latitudeDestination - latitudeSource).toRadians()
        let longitudeDeltaRads = (longitudeDestination - longitudeSource).toRadians()
        
        let a = sin(latitudeDeltaRads / 2) * sin(latitudeDeltaRads / 2) + cos(latitudeSourceRads) * cos(latitudeDestinationRads) * sin(longitudeDeltaRads / 2) * sin(longitudeDeltaRads / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let distance = Euclid.kEarthRadiusMetres * c;
        
        return distance
    }
    
    /// Initial compass bearing (in range of 0 - 360) relative to North from receiver to travel in direction of CLLocationCoordinate2D passed as an argument
    ///
    /// - Parameter coordinate: Target CLLocationCoordinate2D to calculate bearing towards
    /// - Returns: The initial compass bearing required to travel in a straight line to target coordinate
    public func compassBearing(to coordinate: CLLocationCoordinate2D) -> CLLocationDirection {
        let bearing = self.bearing(to: coordinate)
        
        return (bearing.toRadians() + (2 * M_PI)).toDegrees()
    }
    
    /// Initial bearing (in range of -180 - 180) relative to North from receiver to travel in direction of CLLocationCoordinate2D passed as an argument
    ///
    /// - Parameter coordinate: Target CLLocationCoordinate2D to calculate bearing towards
    /// - Returns: The initial bearing required to travel in a straight line to target coordinate
    public func bearing(to coordinate: CLLocationCoordinate2D) -> Bearing {
        
        let latitudeSource = self.latitude
        let longitudeSource = self.longitude
        let latitudeDestination = coordinate.latitude
        let longitudeDestination = coordinate.longitude
        
        let latitudeSourceRads = latitudeSource.toRadians()
        let latitudeDestinationRads = latitudeDestination.toRadians()
        
        let longitudeSourceRads = longitudeSource.toRadians()
        let longitudeDestinationRads = longitudeDestination.toRadians()
        
        let y = sin(longitudeDestinationRads - longitudeSourceRads) * cos(latitudeDestinationRads)
        let x = cos(latitudeSourceRads) * sin(latitudeDestinationRads) - sin(latitudeDestinationRads) * cos(latitudeSourceRads) * cos(longitudeDestinationRads - longitudeSourceRads)
        let bearing = atan2(y, x).toDegrees()
        
        return bearing
    }
}
