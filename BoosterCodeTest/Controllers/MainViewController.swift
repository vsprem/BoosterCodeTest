//
//  MainViewController.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 29.10.2021..
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var btnFuel1: FuelButton!
    @IBOutlet weak var btnFuel2: FuelButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var viewModel: MainViewModel!
    private var defaultLocation = CLLocation(latitude: Coordinates.defaultLatitude, longitude: Coordinates.defaultLongitude)
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnFuel1.isSelected = false
        btnFuel2.isSelected = false
    }
    
    private func setupView() {
        title = viewModel.title
        mapview.showsUserLocation = true
        
        btnFuel1.delegate = self
        btnFuel2.delegate = self
        
        btnNext.setTitle(viewModel.btnContinueTitle, for: .normal)
        btnNext.isEnabled = false
        
        viewModel.getFueldData { arrFuelData in
            btnFuel1.setData(fuelData: arrFuelData[0])
            btnFuel2.setData(fuelData: arrFuelData[1])
        } error: { _ in
            //Not used, otherwise error enumerator would be implemented and used
        }
    }
    
    @IBAction func btnNextAction() {
        guard let fuelData = btnFuel1.isSelected ? btnFuel1.fuelData : btnFuel2.fuelData else { return }
        viewModel.onNextTapped(fuelData: fuelData, location: mapview.centerCoordinate)
    }
}

extension MainViewController: FuelButtonDelegate {
    func didTapFuelButton(sender: FuelButton) {
        if sender == btnFuel1 {
            btnFuel2.isSelected = false
        } else {
            btnFuel1.isSelected = false
        }
        sender.isSelected = true
        btnNext.isEnabled = true
    }
}

extension MainViewController: CLLocationManagerDelegate {
    private func getCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        guard let currentLocation = locationManager.location else {
            mapview.centerToLocation(defaultLocation)
            return
        }
        mapview.centerToLocation(currentLocation)
    }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
