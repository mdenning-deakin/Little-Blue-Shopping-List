//
//  StoreMapViewController.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 20/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreMapViewController: UIViewController, MKMapViewDelegate {

    class StoreAnnotation : NSObject, MKAnnotation {
        var title: String?
        var subtitle: String?
        var coordinate: CLLocationCoordinate2D
        
        init(store: Stores, coordinate: CLLocationCoordinate2D) {
            self.title = store.name
            self.subtitle = store.location
            self.coordinate = coordinate
        }
    }
    
    var store: Stores?
    
    @IBOutlet weak var storeMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.storeMap.delegate = self as! MKMapViewDelegate
        
        self.storeMap.delegate = self
        
        storeMap.setCenter(storeMap.userLocation.coordinate, animated: true)
        
        if store != nil {
            navigationItem.title = store?.name
            
            CLGeocoder().geocodeAddressString((store?.location)!, completionHandler: {
                (placemark, error) in
                let triplocation = placemark![0].location?.coordinate
                self.storeMap.addAnnotation(StoreAnnotation(store: self.store!, coordinate: triplocation!))
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
