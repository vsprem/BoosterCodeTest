//
//  PreloginDelegate.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 31.10.2021..
//

import Foundation
import CoreLocation

protocol  MainCoordinatorDelegate {
    func didTapMainNext(fuelData: FuelData, location: CLLocationCoordinate2D)
    func didTapOrder(data: OrderedData)
    func didTapeCancel()
}
