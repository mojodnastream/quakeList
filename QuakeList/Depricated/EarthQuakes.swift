////
////  EarthQuakes.swift
////  QuakeList
////
////  Created by Frosty on 11/5/17.
////  Copyright © 2017 repgarden. All rights reserved.
////
//
//import Foundation
//
//class Quakes {
//    
//    var vRank = 0
//    
//    // data encapsulation
//    fileprivate var _qMag:String
//    fileprivate var _qPlace:String
//    fileprivate var _qTime:String
//    
//    //Getters
//    
//    var qMag: String {
//        return _qMag
//    }
//    
//    var qPlace: String {
//        return _qPlace
//    }
//    
//    var qTime: String {
//        return _qTime
//    }
//    
//    //Greated from UI
//
//    
//    init(data: JSONDictionary) {
//        
//        
//        //Magnitude of Quake
//        
//        if let mag = data["properties"] as? JSONDictionary,
//            let qMag = mag["mag"] as? String {
//            
//            self._qMag = qMag
//            
//        }
//        else {
//            _qMag = ""
//        }
//        
//        
//        //Location of Quake
//        
//        if let place = data["properties"] as? JSONDictionary,
//            let qPlace = place["place"] as? String {
//            
//            self._qPlace = qPlace
//        }
//        else {
//            _qPlace = ""
//        }
//        
//        //Price
//        
//        if let time = data["properties"] as? JSONDictionary,
//            let qTime = time["time"] as? String {
//            
//            self._qTime = qTime
//        }
//        else {
//            _qTime = ""
//        }
//    }
//    
//}

