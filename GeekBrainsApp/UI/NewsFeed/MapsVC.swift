//
//  MapsVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsVC: UIViewController, UIGestureRecognizerDelegate{
    var pin =  MKPointAnnotation()
    let locationManager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MapsVC.handleLongPress(gestureReconizer:)))
        tapRecognizer.minimumPressDuration = 0.5
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.delegate = self
        self.map.addGestureRecognizer(tapRecognizer)
        pin.title = "My Location"
        map.addAnnotation(pin)
//        guard let annotation = pin else {return}
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        let annotation =  MKPointAnnotation( )
//        annotation.title = "Title"
//        annotation.subtitle = "Subtitle"
//        annotation.coordinate = CLLocationCoordinate2DMake(  55.7522200,  37.6155600)
//        map.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer){
        if (gestureReconizer.state != .began){
            return;
        }
        locationManager.stopUpdatingLocation()
        let point = gestureReconizer.location(in: self.map)
        pin.coordinate = self.map.convert(point, toCoordinateFrom: self.map)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension MapsVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last?.coordinate{
            pin.coordinate = currentLocation
        }
    }
    
}

extension MapsVC: MKMapViewDelegate{
    func mapView( _ mapView:  MKMapView, viewFor annotation:  MKAnnotation) ->  MKAnnotationView? {
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: " MarkerIdentifier") as?
            MKMarkerAnnotationView {
            annotationView.annotation = annotation
            return annotationView}
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MarkerIdentifier")
        annotationView.canShowCallout = true
        annotationView.calloutOffset = CGPoint(x: -5, y:  5)
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        annotationView.annotation = annotation
        return annotationView
    }
}


