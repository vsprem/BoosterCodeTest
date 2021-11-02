//
//  OrderedData.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 01.11.2021..
//

import Foundation

class OrderedData {
    public var fuelType: String
    public var timeOfDelivery: String
    public var price: String
    public var cardNumber: String
    
    init(fuelType: String, timeOfDelivery: String, price: String, cardNumber: String) {
        self.fuelType = fuelType
        self.timeOfDelivery = timeOfDelivery
        self.price = price
        self.cardNumber = cardNumber
    }
}
