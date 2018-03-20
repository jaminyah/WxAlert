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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMapRegion()
        
        let pinTitle = selectedCity.name + ", " + selectedCity.region
        let citylat = selectedCity.latitude
        let citylong = selectedCity.longitude
        let coordinates = CLLocationCoordinate2D(latitude: citylat, longitude: citylong)
        let cityInfo = MKPinInfo(title: pinTitle, coordinate: coordinates)
        
        mapView.addAnnotation(cityInfo)
    }

    func setMapRegion() {
        let location = CLLocation(latitude: selectedCity.latitude, longitude: selectedCity.longitude)
        let cityRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 12000, 12000)
        mapView.setRegion(cityRegion, animated: true)
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
