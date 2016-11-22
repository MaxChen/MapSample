//
//  ViewController.swift
//  MapTracking
//
//  Created by Max on 2016/11/22.
//  Copyright © 2016年 anvapp. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    let manager = CLLocationManager()
    
    
    var myLocations: [CLLocation] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBAction func pressStart(_ sender: Any) {
        checkAuth()
        manager.startUpdatingLocation()
        titleLabel.text = "記錄中"

    }
    @IBAction func pressStop(_ sender: Any) {
        manager.stopUpdatingLocation()
        titleLabel.text = "停止中"
    }
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.requestWhenInUseAuthorization()
        mapView.userTrackingMode = .follow
        
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        
        titleLabel.text = "停止中"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAuth() {
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .denied {
            let alert = UIAlertController(title: "title", message: "plz allow", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!
                    , options: [:], completionHandler: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
                print("cancel")
            }))
            
            
            
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    


}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocations.append(locations.last!)
        
        if myLocations.count > 1 {
            let startIndex = myLocations.count - 1
            let endIndex = myLocations.count - 2
            var area = [myLocations[startIndex].coordinate, myLocations[endIndex].coordinate]
            let polyline = MKPolyline(coordinates: &area, count: area.count)
            mapView.add(polyline)
        }
        
        
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .black
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
}

