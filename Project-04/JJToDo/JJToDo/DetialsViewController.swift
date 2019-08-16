//
//  DetialsViewController.swift
//  JJToDo
//
//  Created by admin on 2019/8/16.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit
import MapKit

class DetialsViewController: UIViewController {
    
    @IBOutlet  var jjMap: MKMapView!
    @IBOutlet  var locationLab: UILabel!
    @IBOutlet  var titleLab: UILabel!
    
    var item: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = item else {
            return
        }
        
        titleLab.text = item.title
        
        if let location = item.location {
            locationLab.text = location.name
            if let cooridnate = location.coordinate {
                centerMapOnLocation(with: cooridnate)
            }
        }
    }
    
    private func centerMapOnLocation(with coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        jjMap.setRegion(coordinateRegion, animated: true)
        
    }

}
