//
//  QuakeListMap.swift
//  QuakeList
//
//  Created by Frosty on 11/16/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import UIKit
import MapKit

class customQuakeCell: UITableViewCell {
    
    @IBOutlet weak var qMagBox: UILabel!
    @IBOutlet weak var qDateTime: UILabel!
    @IBOutlet weak var qDesc: UILabel!
    @IBOutlet weak var qTimeAgo: UILabel!
    
}

class QuakeMapList: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var qMapOfEvents: MKMapView!
    @IBOutlet weak var qPrefFeed: UILabel!
    @IBOutlet weak var qPrefFeedView: UIView!
    
    var locationManager:CLLocationManager!
    var refreshControl: UIRefreshControl!
    var objects: USGSEarthquakeData?
    var trackIndexRowForCallout = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEverything()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        setTitleString(qCase: defaults.string(forKey: "feedPrefSel")!)
        qPrefFeed.text = QuakeStringTitle
        ReachabilityManager.shared.addListener(listener: self as NetworkStatusListener)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self as NetworkStatusListener)
    }
    
    @objc func refresh(sender:UIRefreshControl) {
        getGeoJSON()
        setMapType()
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        qPrefFeed.text = QuakeStringTitle
    }
    
    func loadEverything() {
        qMapOfEvents.delegate = self
        setMapType()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getGeoJSON()
        determineMyCurrentLocation()
        
        //self.title = "What's Shakin? \n \(QuakeStringTitle)"
        qPrefFeedView.layer.borderWidth = 1
        qPrefFeedView.layer.borderColor = UIColor.darkGray.cgColor
        qPrefFeed.text = QuakeStringTitle
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(QuakeMapList.refresh(sender:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    func setMapType() {
        let defaults = UserDefaults.standard
        if isKeyPresentInUserDefaults(key: "feedMapPref") {
            switch defaults.integer(forKey: "feedMapPref") {
            case 0: //standard
                self.qMapOfEvents.mapType = .standard
            case 1: //hybrid
                self.qMapOfEvents.mapType = .hybrid
            case 2: //satalite
                self.qMapOfEvents.mapType = .satellite
            default: //standard
                self.qMapOfEvents.mapType = .hybrid
            }
        }
        else {
            self.qMapOfEvents.mapType = .hybrid
            defaults.set(1, forKey: "feedMapPref") //default to hybrid
        }
    }
    
    func getGeoJSON() {
        USGSEarthquakeData.fetch { (geoJSON, error) in
            self.objects = geoJSON
            self.tableView.reloadData()
        }
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 80000, 80000)
        qMapOfEvents.setRegion(coordinateRegion, animated: true)
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "place"
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else {

            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        if (annotation is CustomPointAnnotation) {
            view.tag = (annotation as! CustomPointAnnotation).tag
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //let annotation = view.annotation
        //let index = (mapView.annotations as NSArray).index(of: annotation!)
        //print ("Annotation Index = \(view.tag)")
        trackIndexRowForCallout = view.tag
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "showQuakeDetail", sender: self)
    }
    
    func centerMap(lat: Double, long: Double) {
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        //qMapOfEvents.centerCoordinate = point.coordinate
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(point.coordinate, 500000, 500000)
        qMapOfEvents.setRegion(coordinateRegion, animated: true)
    }
    
    func drawPoints(lat: Double, long: Double, ptTitle: String, pMag: Double, pTag: Int) {
        let point = CustomPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        point.title = ptTitle
        //point.subtitle = String(pMag)
        point.tag = pTag
        qMapOfEvents.addAnnotation(point)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuakeDetail" {
            let object = objects?.features[trackIndexRowForCallout]
            let controller = segue.destination as! QuakeListDetail
            controller.detailItem = object
        }
        else if segue.identifier == "showSettings" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects?.features.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trackIndexRowForCallout = indexPath.row
        let object = objects?.features[trackIndexRowForCallout]
            centerMap(lat: (object?.geometry.latitude)!, long: (object?.geometry.longitude)!)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customQuakeCell
        let object = objects!.features[indexPath.row]
        
        let place = object.properties.place
        if let qPlace = place.components(separatedBy: " of ").last {
            cell.qDesc.text = qPlace
        }
        else {
             cell.qDesc.text = place
        }
  
        cell.qMagBox.layer.cornerRadius = cell.qMagBox.frame.size.height/2.0
        cell.qMagBox.layer.masksToBounds = true
        cell.qMagBox.layer.borderWidth = 1
        cell.qMagBox.layer.borderColor = UIColor.gray.cgColor
        cell.qMagBox.text = String(format: "%.01f", object.properties.mag)
       
        if object.properties.mag > 5.99 {
            cell.qMagBox.textColor = UIColor.red
        }
        else {
            cell.qMagBox.textColor = UIColor.orange
        }

        let dateTimeStrings = dateTimeString(from: object.properties.time)
        cell.qDateTime?.text = dateTimeStrings
        
        let theDate = dateTime(from: object.properties.time)
        let theDiff = dateDiff(qDate: theDate).dropFirst()
        cell.qTimeAgo.layer.cornerRadius = 10
        cell.qTimeAgo.layer.masksToBounds = true
        cell.qTimeAgo.layer.borderWidth = 1
        cell.qTimeAgo.layer.borderColor = UIColor.gray.cgColor
        cell.qTimeAgo.text = String(theDiff)  //"\(theDiff) ago"
        
        drawPoints(lat: Double(object.geometry.latitude), long: Double(object.geometry.longitude), ptTitle: object.properties.place, pMag: object.properties.mag, pTag: indexPath.row)
        
        return cell
    }
    
    func doAlert() {

        let alert = UIAlertController(title: "No Connectivity", message: "What's Skakin requires an internet connection to work correctly", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension QuakeMapList: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        
        switch status {
        case .none:
            //debugPrint("ViewController: Network became unreachable")
            doAlert()
        case .wifi:
            debugPrint("QuakeMapList: Network reachable through WiFi")
        case .cellular:
            debugPrint("QuakeMapList: Network reachable through Cellular Data")
        }
    }
}
