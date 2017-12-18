//
//  QuakeListDetailTVC.swift
//  QuakeList
//
//  Created by Frosty on 11/9/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import UIKit
import MapKit

class QuakeListDetail: UIViewController, MKMapViewDelegate {
    
    var quakeID = ""
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var qMagDescription: UILabel!
    @IBOutlet weak var qTitle: UILabel!
    @IBOutlet weak var qFeltOnOff: UIImageView!
    @IBOutlet weak var qDate: UILabel!
    @IBOutlet weak var qTime: UILabel!
    @IBOutlet weak var qPlaceMap: MKMapView!
    @IBOutlet weak var btnFeltIt: UIButton!
    
    @IBAction func btnFeltIt(_ sender: UIButton) {

        if let index = arrFeltIt.index(of:quakeID) {
            arrFeltIt.remove(at: index)
            btnFeltIt.setTitle("Did You Feel It", for: .normal)
            qFeltOnOff.isHidden = true
        }
        else {
            arrFeltIt.append(quakeID)
            btnFeltIt.setTitle("Nope, Didn't Feel It", for: .normal)
            qFeltOnOff.isHidden = false
        }
        defaults.set(arrFeltIt, forKey: "didFeelIt")
        
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()

            qPlaceMap.delegate = self
            configureView()
            setMapType()
            unpackActivity()
        }
    
    func unpackActivity() {
        
        if isKeyPresentInUserDefaults(key: "didFeelIt") {
            arrFeltIt = defaults.array(forKey: "didFeelIt") as! [String]
            qFeltOnOff.isHidden = true
        }
        else {
            defaults.set(arrFeltIt, forKey: "didFeelIt")
        }
        
        if arrFeltIt.index(of:quakeID) != nil {
            btnFeltIt.setTitle("Nope, Didn't Feel It", for: .normal)
            qFeltOnOff.isHidden = false
        }
        else {
            btnFeltIt.setTitle("Did You Feel It", for: .normal)
            qFeltOnOff.isHidden = true
        }
    }
    
    func setMapDesc(theMag: String) {
        switch theMag {
        case "8":
            qMagDescription.text = QuakeMagNotes7Plus
        case "7":
            qMagDescription.text = QuakeMagNotes7Plus
        case "6":
            qMagDescription.text = QuakeMagNotes6
        case "5":
            qMagDescription.text = QuakeMagNotes5
        case "4":
            qMagDescription.text = QuakeMagNotes4
        case "3":
            qMagDescription.text = QuakeMagNotes3
        default:
            qMagDescription.text = QuakeMagNotes3
        }
        
//        qMagDescription.layer.cornerRadius = 10
//        qMagDescription.layer.masksToBounds = true
//        qMagDescription.layer.borderWidth = 1
//        qMagDescription.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setMapType() {
        let defaults = UserDefaults.standard
        if isKeyPresentInUserDefaults(key: "feedMapPref") {
            switch defaults.integer(forKey: "feedMapPref") {
            case 0: //standard
                self.qPlaceMap.mapType = .standard
            case 1: //hybrid
                self.qPlaceMap.mapType = .hybrid
            case 2: //satalite
                self.qPlaceMap.mapType = .satellite
            default: //standard
                self.qPlaceMap.mapType = .hybrid
            }
        }
    }
    
        var detailItem: USGSEarthquakeData.Feature? {
            didSet {
                // Update the view.
                configureView()
            }
        }
    
        func configureView() {
            if let detail = detailItem {
                
                if let label = qTitle {
                    let thePlace = detail.properties.place
                    //let location = CLLocation(latitude: detail.geometry.latitude, longitude: detail.geometry.longitude)
                    //print("lat: \(detail.geometry.latitude) lon: \(detail.geometry.longitude)" )
                    
//                    fetchCountryAndCity(location: location) { country, city in
//                        print("city:", city)
//                        print("country:", country)
//                        thePlace = "\(city), \(country)"
//                    }
                    
//                    if thePlace.isEmpty {
//                        if let qPlace = detail.properties.place.components(separatedBy: " of ").last {
//                            thePlace = "Near \(qPlace)"
//                        }
//                    }
                    self.title = thePlace

                    var magString = magnitudeString(from: detail.properties.mag, magType: detail.properties.magType)
                    let subst = magString.prefix(3)
                    magString = String(subst)
                    let getMagDesc = String(magString.prefix(1))
                    setMapDesc(theMag: getMagDesc)
                    //qPlace.text = detail.properties.place
                    

                    
                    btnFeltIt.layer.borderWidth = 1
                    btnFeltIt.layer.borderColor = UIColor(red:0.31, green:0.47, blue:0.81, alpha:1.0).cgColor
                    
                    qDate.layer.cornerRadius = label.frame.size.height/2.0
                    qDate.layer.masksToBounds = true
                    qDate.layer.borderWidth = 2
                    qDate.layer.borderColor = UIColor.gray.cgColor
                    qDate.text = dateString(from: detail.properties.time)
                    
                    qTime.layer.cornerRadius = label.frame.size.height/2.0
                    qTime.layer.masksToBounds = true
                    qTime.layer.borderWidth = 2
                    qTime.layer.borderColor = UIColor.gray.cgColor
                    qTime.text = timeString(from: detail.properties.time)
                    
                    //print("The ID: \(detail.id)")
                    quakeID = detail.id
                    
                    let point = MKPointAnnotation()
                        point.coordinate = CLLocationCoordinate2D(latitude: detail.geometry.latitude, longitude: detail.geometry.longitude)
                        point.title = "Epicenter \n \(magString)"
                    
//                        qPlaceMap.addAnnotation(point)
//                        qPlaceMap.centerCoordinate = point.coordinate
                    
                    let coordinateRegion = MKCoordinateRegionMakeWithDistance(point.coordinate, 100000, 100000)
                    qPlaceMap.setRegion(coordinateRegion, animated: true)
                     qPlaceMap.addAnnotation(point)
                    
                    label.layer.cornerRadius = label.frame.size.height/2.0
                    label.layer.masksToBounds = true
                    label.layer.borderWidth = 2
                    label.layer.borderColor = UIColor.darkGray.cgColor
                    label.text = "M " + magString
                }
            }
        }
}

