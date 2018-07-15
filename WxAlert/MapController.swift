//
//  MapController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {
    
    var selectedCity = City()
    @IBOutlet weak var mapView: MKMapView!
    
    //let rootController = RootController()
    let rootController = RootController.sharedInstance
    var delegate: CityProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapController - viewDidLoad")

        // Do any additional setup after loading the view.
        self.delegate = rootController
        
        // Delegate action
        self.delegate?.addNewCity(city: selectedCity)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("MapController - viewWillAppear")
        
        setMapRegion()
        
        let pinTitle = selectedCity.cityName + ", " + selectedCity.region.state
        let citylat = selectedCity.coordinates.latitude
        let citylong = selectedCity.coordinates.longitude
        let coordinates = CLLocationCoordinate2D(latitude: citylat, longitude: citylong)
        let cityInfo = MKPinInfo(title: pinTitle, coordinate: coordinates)
        
        mapView.addAnnotation(cityInfo)
    }

    func setMapRegion() {
        let location = CLLocation(latitude: selectedCity.coordinates.latitude, longitude: selectedCity.coordinates.longitude)
        let cityRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 12000, 12000)
        mapView.setRegion(cityRegion, animated: true)
    }
}

extension MapController: MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation { return nil }
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        

        // Initial startup - Enable weather and settings tab
        let cityCount = delegate?.getCityCount()
        if cityCount! >= 1 {
            self.tabBarController?.viewControllers?[1].tabBarItem.isEnabled = true
            self.tabBarController?.viewControllers?[2].tabBarItem.isEnabled = true
        }
        
        // Set Weather as default view
        let tabBarController = self.tabBarController as? RootController
        tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[1]

    }
    
}
