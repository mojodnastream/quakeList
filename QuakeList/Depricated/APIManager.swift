////
////  APIManager.swift
////  QuakeList
////
////  Created by Frosty on 11/5/17.
////  Copyright © 2017 repgarden. All rights reserved.
////
//
//import Foundation
//class APIManager {
//    
//    func loadData(urlString:String, completion: @escaping ([Quakes])-> Void) {
//        
//        let config = URLSessionConfiguration.ephemeral
//        let session = URLSession(configuration: config)
//        
//        //let session = NSURLSession.sharedSession()
//        let url = NSURL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson")!
//        //let url = NSURL(string: "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json")!
//        let task = session.dataTask(with: url as URL) {
//            (data, response, error) -> Void in
//            
//            if error != nil {
//                
//                print(error!.localizedDescription)
//            } else {
//                
//                print(data!)
//                //let quakes = self.parseJson(data: data as NSData?)
//                
//                do {
//                    
//                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary,
//                        let features = json["type"] as? JSONDictionary,
//                        let props = features["FeatureCollection"] as? JSONArray {
//                        
//                        var quakes = [Quakes]()
//                        
//                        for prop in props {
//                            let prop = Quakes(data: prop as! JSONDictionary)
//                            quakes.append(prop)
//                        }
//                        
//                        let i = quakes.count
//                        print("USGS API Quakes = total count --> \(i)")
//                       
//                        //let priority = DispatchQueue.global(qos: .default)
//                        
//                        DispatchQueue.global(qos: .default).async() {
//                            DispatchQueue.main.async() {
//                                completion(quakes)
//                            }
//                        }
//                        
//                    }
//                } catch {
//                    
//                    print("error in NSJSONSerialization")
//                    
//                }
//                
//            }
//        }
//        task.resume()
//    }
//}

