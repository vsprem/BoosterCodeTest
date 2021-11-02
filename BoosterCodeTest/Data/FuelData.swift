//
//  FuelData.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 30.10.2021..
//

import Foundation

class FuelData {
    public var price: String
    public var fuelName: String
    
    init(fuelName: String, price: String) {
        self.fuelName = fuelName
        self.price = price
    }
}
