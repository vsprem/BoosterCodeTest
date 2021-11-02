//
//  OrderData.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 31.10.2021..
//

import Foundation

class OrderData {
    public var deliveryTimes: [DeliveryTimeData]
    public var cards: [CardData]
    
    init(deliveryTimes: [DeliveryTimeData], cards: [CardData]) {
        self.deliveryTimes = deliveryTimes
        self.cards = cards
    }
}
