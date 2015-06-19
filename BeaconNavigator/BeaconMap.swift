//
//  BeaconMap.swift
//  BeaconNavigator
//
//  Created by Alex Deutsch on 10.06.15.
//  Copyright (c) 2015 Alexander Deutsch. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class BeaconMap {
    
    
    let name : String
    var edgeCoordinates : [CGPoint] = []
    
    // Beacon Minor Value(Int) : Point(CGPoint)
    private var beaconCoordinates : [Int : CGPoint] = [:]
    
    required init(fileName : String) {
        if  let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let beacons = dictionary["beacons"] as? Dictionary<String,Dictionary<String,NSNumber>>,
            let edges = dictionary["edges"] as? Array<Dictionary<String,NSNumber>> {
            
                // Read Edges
                for edge in edges {
                    let edgePoint = CGPointMake(CGFloat(edge["x"]!.floatValue), CGFloat(edge["y"]!.floatValue))
                    edgeCoordinates.append(edgePoint)
                }
                
                // Read Beacon Coordinates
                for (beaconMinor, coordinate) in beacons {
                    let coordinate = CGPoint(x: CGFloat(coordinate["x"]!.floatValue), y: CGFloat(coordinate["y"]!.floatValue))
                    beaconCoordinates[beaconMinor.toInt()!] = coordinate
                    
                }
        }
        else {
            NSLog("Error Loading Map with name: \(fileName), either map file was not found or the map does not contain all required parameters")
        }
        name = fileName
    }
    

    /* maps a beacon to a point in the map
    @param beacon the beacon to be mapped
    @return the matching point in the map of the beacon, nil if the beacon was not found on the map
    */
    func coordinateForBeacon(beacon : CLBeacon) -> CGPoint? {
        let minorValue = beacon.minor.integerValue
        let coordinate = beaconCoordinates[minorValue]
        return coordinate
    }
    
    /* Returns a dictionary of beacons and corresponding points
    @param beacons an array of beacons to map with points
    @return dictionary of beacons and corresponding points
    */
    func beaconCoordinatesForBeacons(beacons : [CLBeacon]) -> [CLBeacon:CGPoint] {
        var beaconCoordinates : [CLBeacon:CGPoint] = [:]
        for beacon in beacons {
            if let coordinate = coordinateForBeacon(beacon) {
                beaconCoordinates[beacon] = coordinate
            }
        }
        return beaconCoordinates
    }
    
    /* Check if that beacon is on that map 
    @return boolean value if the beacon positioned on in this map
    */
    func beaconIsOnMap(beacon : CLBeacon) -> Bool {
        return contains(beaconCoordinates.keys.array, beacon.minor.integerValue)
    }
}