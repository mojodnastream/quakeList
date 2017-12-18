//
//  DataFormatters.swift
//  QuakeList
//
//  Created by Frosty on 11/6/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import UIKit

// Use to convert time and updated to Date from utc since 1970
func dateTime(from timeInterval: Int) -> Date {
    return Date(timeIntervalSince1970: TimeInterval(Double(timeInterval) / 1000.0))
}

func dateString(from timeInterval: Int) -> String {
    let date = dateTime(from: timeInterval)
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter.string(from: date)
}

func timeString(from timeInterval: Int) -> String {
    let date = dateTime(from: timeInterval)
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .medium
    return formatter.string(from: date)
}

func dateTimeString(from timeInterval: Int) -> String {
    let date = dateTime(from: timeInterval)
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter.string(from: date)
}

func latitudeString(from latitude: Double) -> String {
    let direction = latitude > 0 ? "N" : "S"
    return String(format: "%.3f° %@", abs(latitude), direction)
}

func longitudeString(from longitude: Double) -> String {
    let direction = longitude > 0 ? "E" : "W"
    return String(format: "%.3f° %@", abs(longitude), direction)
}

func depthString(from depth: Double) -> String {
    let formatter = LengthFormatter()
    return formatter.string(fromValue: depth, unit: .kilometer)
}

func alertColor(from alert: USGSEarthquakeData.Feature.Properties.Alert?) -> UIColor {
    guard let alert = alert else { return .white }
    
    let color: UIColor
    
    switch alert {
    case .green:
        color = .green
    case .yellow:
        color = .yellow
    case .orange:
        color = .orange
    case .red:
        color = .red
    }
    
    return color
}

func magnitudeString(from mag: Double, magType: String) -> String {
    return "\(mag) \(magType)"
}

//func statusString(from status: USGSEarthquakeData.Feature.Properties.Status) -> String {
//    return status.rawValue.uppercased()
//}

func tsunamiString(from tsunami: USGSEarthquakeData.Feature.Properties.Tsunami) -> String {
    return tsunami == .possible ? "🌊" : ""
}

