# Euclid
___

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/niceagency/LocationMonitor)

#### Supports Swift 3

Euclid is a cross-platform utility class written in Swift 3 that provides convenience methods allowing the  user to perform Great-Circle mathematics with ease.

## Features
___

* Distance between two given coordinates
* Initial bearing given source and destination coordinates
* `toRadians()` and `toDegrees()` helper methods
* Destination coordinate given a start coordiante, distance and bearing
* Supports bearings in the range -180 - 180 degrees and bearings in a compass range of 0 - 360 degrees.
* 100% unit test coverage

##### System requirements

+ iOS 9.0+
+ Xcode 8.0+
+ Swift 3.0+

## Usage
___

###  Euclid

``` Swift
public static func destination(start: CLLocationCoordinate2D, distance: CLLocationDistance, bearing: Bearing) -> CLLocationCoordinate2D { } // Destionation coordinate given start, distance and bearing
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

## Installation
___

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

`$ brew update`

`$ brew install carthage`

To integrate Euclid into your Xcode project using Carthage, specify it in your Cartfile:

`github "timsearle/Euclid"`

Run `carthage update` to build the framework and drag the built Euclid.framework into your Xcode project.

## Additional Information
___

This library is written in Swift 3.

## Contributions
___

If you wish to contribute to Euclid please fork the repository and send a pull request or raise an issue within GitHub.

## License
___

Euclid is released under the MIT license. See LICENSE for details.
