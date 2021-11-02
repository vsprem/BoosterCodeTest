//
//  MainViewModel.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 31.10.2021..
//

import Foundation
import CoreLocation

class MainViewModel {
    private var arrFuelData: [FuelData]?
    public var delegate: MainCoordinatorDelegate?
    
    public var title: String {
        return "Booster"
    }
    
    public var btnContinueTitle: String {
        return "Next"
    }
    
    init(delegate: MainCoordinatorDelegate) {
        self.delegate = delegate
    }
    
    public func getFueldData(success: (([FuelData]) -> Void), error: ((Error) -> Void)) {
        DataService.getFueldData { [weak self] arrFuelData in
            self?.arrFuelData = arrFuelData
            success(arrFuelData)
        } error: { error in
            //Not used
        }
    }
    
    public func onNextTapped(fuelData: FuelData, location: CLLocationCoordinate2D) {
        delegate?.didTapMainNext(fuelData: fuelData, location: location)
    }
}
