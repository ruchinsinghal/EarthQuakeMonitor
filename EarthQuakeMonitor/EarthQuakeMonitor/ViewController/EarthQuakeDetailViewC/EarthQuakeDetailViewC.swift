//
//  EarthQuakeDetailViewC.swift
//  EarthQuakeMonitor
//
//  Created by Ruchin Singhal on 23/02/22.
//

import UIKit
import MapKit

class EarthQuakeDetailViewC: UIViewController {
  
  var earthQuakeDetailViewModel = EarthQuakeDetailViewModel()
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var lblMagnitude: UILabel!
  @IBOutlet weak var lblLocation: UILabel!
  @IBOutlet weak var lblDateTime: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    navigationItem.title = earthQuakeDetailViewModel.earthQuakeFeature.properties.title
    
    let longitude = earthQuakeDetailViewModel.earthQuakeFeature.geometry.coordinates[0]
    let latitude = earthQuakeDetailViewModel.earthQuakeFeature.geometry.coordinates[1]
    mapView.centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    mapView.isZoomEnabled = true
    mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 200000, maxCenterCoordinateDistance: 300000)
    
    let annotation = MKPointAnnotation()
    let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    annotation.coordinate = centerCoordinate
    annotation.title = earthQuakeDetailViewModel.earthQuakeFeature.properties.title
    mapView.addAnnotation(annotation)
    
    lblMagnitude.text = "\(earthQuakeDetailViewModel.earthQuakeFeature.properties.mag)"
    lblLocation.text = earthQuakeDetailViewModel.earthQuakeFeature.properties.place
    
    let date = Date.init(timeIntervalSince1970: earthQuakeDetailViewModel.earthQuakeFeature.properties.time / 1000)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
    lblDateTime.text = dateFormatter.string(from: date)
  }
}
