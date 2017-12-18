////
////  QuakeMap.swift
////  QuakeList
////
////  Created by Frosty on 11/12/17.
////  Copyright © 2017 repgarden. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class QuakeMap: UIViewController, MKMapViewDelegate {
//
//    @IBOutlet weak var qMapOfEvents: MKMapView!
//    var qLat = ""
//    var qLong = ""
//    var qTitle = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        qMapOfEvents.delegate = self
//        processPoints()
//    }
//
//    func processPoints() {
//        var i = 1
//        for item in qMapArray {
//            //print(item)
//            if i == 1 {
//                qLat = item
//            } else if i == 2 {
//                qLong = item
//            } else if i == 3 {
//                qTitle = item
//                i = 0
//                drawPoints(lat: Double(qLat)!, long: Double(qLong)!, ptTitle: qTitle)
//            }
//            i += 1
//        }
//    }
//
//    func drawPoints(lat: Double, long: Double, ptTitle: String) {
//        let point = MKPointAnnotation()
//        point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        point.title = ptTitle
//        qMapOfEvents.addAnnotation(point)
//        //qMapOfEvents.centerCoordinate = point.coordinate
//    }
//}
//
