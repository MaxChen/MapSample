//
//  ViewController.swift
//  MapAnnotation
//
//  Created by Max on 2016/11/22.
//  Copyright © 2016年 anvapp. All rights reserved.
//

import UIKit
import MapKit

struct Location {
    let title: String
    let lat: Double
    let lon: Double
}

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let annotationsLocations = [
        Location(title: "test", lat: 25.017354, lon: 121.539907),
        Location(title: "test2", lat: 25.027354, lon: 121.639907),
        Location(title: "test3", lat: 25.037354, lon: 121.739907)
    ]
    
    func addAnnotations() {
        
//        let annotations = annotationsLocations.map { location -> MKPointAnnotation in
//            let annotation = MKPointAnnotation()
//            annotation.title = location.title
//            annotation.coordinate = CLLocationCoordinate2DMake(location.lat, location.lon)
//            return annotation
//        }
//        mapView.addAnnotations(annotations)
        
        
        for location in annotationsLocations {
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2DMake(location.lat, location.lon)
            mapView.addAnnotation(annotation)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addAnnotations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

