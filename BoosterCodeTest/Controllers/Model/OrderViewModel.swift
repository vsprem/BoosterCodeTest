//
//  OrderViewModel.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 31.10.2021..
//

import Foundation
import CoreLocation

class OrderViewModel {
    public var delegate: MainCoordinatorDelegate!

    public var orderData: OrderData!
    
    public var headerTitles = ["Select delivery time",
                               "Select payment method"]
    
    public var selectedDeliveryTimeIndex = -1
    public var selectedCardIndex = -1
    
    public var title: String {
        return "Order Boost"
    }
    
    public var btnTitle: String {
        return "Order"
    }
    
    public var fuelData: FuelData
    public var location: CLLocationCoordinate2D
    
    init(fuelData: FuelData, location: CLLocationCoordinate2D, delegate: MainCoordinatorDelegate) {
        self.fuelData = fuelData
        self.location = location
        self.delegate = delegate
    }
    
    public func getOrderData(success: () -> Void, error: (Error) -> Void) {
        DataService.getOrderData { [weak self] orderData in
            self?.orderData = orderData
            success()
        } error: { _ in
            //Not used
        }
    }
    
    public func sendOrder() {
        let deliveryTimeData = orderData.deliveryTimes[selectedDeliveryTimeIndex]
        let card = orderData.cards[selectedCardIndex]
        
        let order = ["fuelType": fuelData.fuelName,
                     "fuelPrice": fuelData.price,
                     "latitude": String(location.latitude),
                     "longitude": String(location.longitude),
                     "deliveryTimeId": deliveryTimeData.timeId,
                     "deliveryTimeName": deliveryTimeData.name,
                     "cardNumberId": card.cardId,
                     "cardNumber": card.cardNumber]
        
        
        DataService.sendOrder(data: order) { [weak self] orderedData in
            self?.delegate.didTapOrder(data: orderedData)
        } error: { _ in
            //Not used
        }

    }
}
