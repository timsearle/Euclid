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

public class Euclid {
    
    public static let kEarthRadiusMetres = 6371e3
    
    public static func destination(start: CLLocationCoordinate2D, distance: CLLocationDistance, bearing: Bearing) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    public static func destination(start: CLLocationCoordinate2D, distance: CLLocationDistance, compassBearing: CLLocationDirection) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}

public extension CLLocationDegrees {
    
    public func toRadians() -> Radians {
        return self * (M_PI / 180)
    }
}

public extension Radians {
    public func toDegrees() -> CLLocationDegrees {
        return self / (M_PI / 180)
    }
}

public extension CLLocationCoordinate2D {
    
    public func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        
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
    
    public func compassBearing(to coordinate: CLLocationCoordinate2D) -> CLLocationDirection {
        let bearing = self.bearing(to: coordinate)
        
        return (bearing.toRadians() + (2 * M_PI)).toDegrees()
    }
    
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
