////
////  QuakeListTVC.swift
////  QuakeList
////
////  Created by Frosty on 11/5/17.
////  Copyright © 2017 repgarden. All rights reserved.
////
//
//import UIKit
//
//class QuakeListTVC: UITableViewController {
//    
//    //var quakes = [Quakes]()
//    var objects: USGSEarthquakeData?
//    //@IBOutlet weak var tableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if qMapArray.count > 0 {
//            qMapArray.removeAll()
//        }
//        //runAPI()
//        
//        USGSEarthquakeData.fetch { (geoJSON, error) in
//            self.objects = geoJSON
//            self.tableView.reloadData()
//            // TODO: handle error
//        }
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showQuakeDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let object = objects?.features[indexPath.row]
//                let controller = segue.destination as! QuakeListDetail
//                controller.detailItem = object
//            }
//        } else if segue.identifier == "ShowQuakeMap" {
////            if let indexPath = tableView.indexPathForSelectedRow {
////                let object = objects?.features[indexPath.row]
////                let controller = segue.destination as! QuakeMap
////                controller.detailItem = object
////                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
////                controller.navigationItem.leftItemsSupplementBackButton = true
////            }
//        }
//        else if segue.identifier == "ShowQuakeMapList" {
//            //for later
//        }
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return objects?.features.count ?? 0
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//       
//        let object = objects!.features[indexPath.row]
//        cell.textLabel!.text = object.properties.title
//        //print("Lat \(object.geometry.latitude) : Long \(object.geometry.longitude) : Place : \(object.properties.place)")
//        
//        qMapArray.append(String(object.geometry.latitude))
//        qMapArray.append(String(object.geometry.longitude))
//        qMapArray.append(object.properties.place)
//        
//        //print(qMapArray.count)
//        
//        let dateTime = dateTimeString(from: object.properties.time)
//        cell.detailTextLabel?.text = dateTime
//        return cell
//    }
//}
//    
////    func numberOfSections(in tableView: UITableView) -> Int {
////        // #warning Incomplete implementation, return the number of sections
////        return 1
////    }
////
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        // #warning Incomplete implementation, return the number of rows
////        //print(quakes.count)
////        return quakes.count
////
////    }
////
////    fileprivate struct storybaord {
////        static let cellReuseIdentifier = "shakeCell"
////        //static let sequeIdentifier = "musicDetail"
////
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////        let cell = tableView.dequeueReusableCell(withIdentifier: storybaord.cellReuseIdentifier, for: indexPath) as!QuakeListCell
////
////        cell.quake = quakes[(indexPath as NSIndexPath).row]
////
////        return cell
////    }
////
//    //    func runAPI() {
//    //        //call API
//    //        let api = APIManager()
//    //        api.loadData(urlString: APIString, completion: didLoadData)
//    //    }
//    //
//    //    func didLoadData(_ quakes: [Quakes]) {
//    //        self.quakes = quakes
//    //        for item in quakes {
//    //            print("name = \(item.qMag)")
//    //        }
//    //
//    //        for (index, item) in quakes.enumerated() {
//    //            print("\(index) name = \(item.qPlace)")
//    //        }
//    //
//    //        //tableView.reloadData()
//    //
//    //    }

