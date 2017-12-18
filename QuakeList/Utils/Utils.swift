//
//  Utils.swift
//  QuakeList
//
//  Created by Frosty on 11/20/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

func setTitleString(qCase: String) {
    
    switch qCase {
        case "0":
            QuakeStringTitle = "Large Quakes - Past Month"
        case "1":
            QuakeStringTitle = "4.5+ - Past Week"
        case "2":
            QuakeStringTitle = "M 2.5+ - Past 24 Hours"
        case "3":
            QuakeStringTitle = "All Quakes - Past Hour"
        default:
            QuakeStringTitle = "Large Quakes - Past Month"
    }
}

func dateDiff(qDate: Date) -> String {
    let now = Date()
    let endDate = qDate

    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .hour, .day,]
    formatter.unitsStyle = .abbreviated
    
    let dateInfo = formatter.string(from: now, to: endDate)!
    return dateInfo
}

func stringToDate(strDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-mm-yyyy" //Your date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
    let date = dateFormatter.date(from: "01-01-2017")! //according to date format your date string
    return date
}

//func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String) -> ()) {
//    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//        if let error = error {
//            print("the Error is \(error)")
//        } else if let country = placemarks?.first?.isoCountryCode,
//            let city = placemarks?.first?.locality {
//            completion(country, city)
//        }
//    }
//}
//let location = CLLocation(latitude: object.geometry.latitude, longitude: object.geometry.longitude)

//        fetchCountryAndCity(location: location) { country, city in
//            print("city:", city)
//            print("country:", country)
//            //self.qPlace = "\(city), \(country)"
//            //cell.qDesc.text = self.qPlace
//            //cell.qDesc.text = city
//        }


