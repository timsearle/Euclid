# Euclid
___

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/timsearle/Euclid) [![GitHub version](https://badge.fury.io/gh/timsearle%2Feuclid.svg)](https://badge.fury.io/gh/timsearle%2Feuclid)

#### Supports Swift 5.0

Euclid is a cross-platform (iOS, macOS, tvOS, watchOS) utility class written in Swift that provides convenience methods allowing the  user to perform Great-Circle mathematics with ease.

## Features
___

* Calculates the distance between two given coordinates
* Calculates the initial bearing when given source and destination coordinates
* Includes `toRadians()` and `toDegrees()` helper methods as extensions on `CLLocationDegrees`
* When given a start coordinate, bearing and distance to travel a destination coordinate is calculated
* Supports bearings in the range -180 to 180 degrees and bearings in a compass range of 0 to 360 degrees
* 100% unit test coverage

##### System requirements

+ Deployment target of iOS 9.0+ / macOS 10.11+ / tvOS 10.1+ / watchOS 3.1+
+ Xcode 10.0+
+ Swift 5.0+

## Usage
___

###  Euclid

The key Great-Circle method provided by the library is `destination` and this is accessible as a static func on the `Euclid` class.

``` Swift
public static func destination(start: CLLocationCoordinate2D, distance: CLLocationDistance, bearing: Bearing) -> CLLocationCoordinate2D { } // Destination coordinate given start, distance and bearing
let calculatedDestination = Euclid.destination(start: source, distance: 100000, bearing: bearing)
```

### Extensions on `CLLocationCoordinate2D`

``` Swift
public func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance { }
source.distance(from: destination) // Distance in metres

public func bearing(to coordinate: CLLocationCoordinate2D) -> CLLocationDirection { }
source.bearing(to: destination) // Bearing in range -180 - 180

public func bearing(to coordinate: CLLocationCoordinate2D) -> Bearing { }
source.compassBearing(to: destination) // Bearing in range 0 - 360
```

### Useful constants and types

``` Swift
Euclid.kEarthRadiusMetres // Radius of the earth in metres used by all calculations (6371e3)

public typealias Bearing = Double // Representing a bearing in the range -180 - 180
```

In addition to `Euclid` there is an additional type of `BoundingBox` that can be used to represent rectangular areas on a sphere.

``` Swift
public struct BoundingBox : CustomStringConvertible, CustomDebugStringConvertible {
    public let lowerLeft: CLLocationCoordinate2D
    public let upperRight: CLLocationCoordinate2D
    public let diagonal: CLLocationDistance
    public let midpoint: CLLocationCoordinate2D
}
```

## Installation
___

### Carthage

To integrate Euclid into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your Cartfile:

`github "timsearle/Euclid"`

Run `carthage update` to build the framework and drag the built Euclid.framework into your Xcode project and update your run scripts as appropriate. For additional support, please visit the Carthage [documentation](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos).

## Apps using Euclid
___

We'd love to hear what you have used Euclid for, if you would like your app displayed here, please send a pull request!

* #### [Eagle](https://itunes.apple.com/ao/app/eagle/id1071087462?mt=8)


## Contributions
___

Currently Euclid has all the features that it was originally developed for, but the world of Euclidean geometry is far larger. If you wish to contribute to Euclid please fork the repository and send a pull request. Contributions and feature requests are always welcome, please do not hesistate to raise an issue with the appropriate label so that any contributors can see.

## License
___

Euclid is released under the MIT license. See LICENSE for details.
