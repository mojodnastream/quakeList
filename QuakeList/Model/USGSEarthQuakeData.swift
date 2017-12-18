//
//  USGSEarthQuakeData.swift
//  QuakeList
//
//  Created by Frosty on 11/6/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import Foundation

struct USGSEarthquakeData: Codable {
    
    struct Feature: Codable {
        let id: String
        
        struct Properties: Codable {
            let title: String
            let mag: Double
            let place: String
            let time: Int
            let updated: Int
            let magType: String
            let ids: String
            
            enum Tsunami: Int, Codable {
                case none
                case possible
            }
            let tsunami: Tsunami
            
            let detail: String
            
            enum Alert: String, Codable {
                case green
                case yellow
                case orange
                case red
            }

            let alert: Alert?
        }
        
        let properties: Properties
        
        struct Geometry: Codable {
            let coordinates: [Double]
            
            var longitude: Double { return coordinates[0] }
            var latitude: Double { return coordinates[1] }
            var depth: Double { return coordinates[2] }
        }
        
        let geometry: Geometry
    }
    
    let features:  [Feature]
    let bbox: [Double]
    
    var minimumLongitude: Double { return bbox[0] }
    var minimumLatitude: Double { return bbox[1] }
    var minimumDepth: Double { return bbox[2] }
    var maximumLongitude: Double { return bbox[3] }
    var maximumLatitude: Double { return bbox[4] }
    var maximumDepth: Double { return bbox[5] }
}

extension USGSEarthquakeData {
    
    static func fetch(_ completionBlock: @escaping ((USGSEarthquakeData?, Error?)->())) {
        let defaults = UserDefaults.standard
        var earthquakesURL =  QuakeStringMonthSig
       
        if isKeyPresentInUserDefaults(key: "feedPref") {
            earthquakesURL = defaults.string(forKey: "feedPref")!
            setTitleString(qCase: defaults.string(forKey: "feedPrefSel")!)
        }
        else {
            //set to the defaults and the user can update in settings
            defaults.set(QuakeStringMonthSig, forKey: "feedPref")
            defaults.set(0, forKey: "feedPrefSel")
            QuakeStringTitle = "Large Quakes - Past Month"
        }
        
        let url = URL(string: earthquakesURL)!
        DispatchQueue.global().async {
            do {
                let allData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let geoJSON = try decoder.decode(USGSEarthquakeData.self, from: allData)
                DispatchQueue.main.async {
                    completionBlock(geoJSON, nil)
                }
            }
            catch let error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    completionBlock(nil, error)
                }
            }
        }
        
    }
}
