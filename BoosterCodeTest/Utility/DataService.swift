//
//  DataService.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 30.10.2021..
//

import Foundation

class DataService {
    
    /// Fake service invoker for obtaining fuel type name and price.
    ///
    /// - Parameters:
    ///   - success: callback with array containg FueldData objects
    ///   - error: callback with error, for the sake of simplicity not used in this example - e.g. if no data is received
    
    public static func getFueldData(success: ([FuelData]) -> Void, error: (Error) -> Void) {
        let arrFuelData: [FuelData] = [FuelData(fuelName: "Regular 87", price: "$2.40"),
                                        FuelData(fuelName: "Premium 91", price: "$2.80")]
        
        success(arrFuelData)
    }
    
    /// Fake service invoker for obtaining possible times of delivery and payment method assuming payment method is stored on server, not locally. If locally, then we can save sensitive data in Keychain or UserDefaults
    ///
    /// - Parameters:
    ///   - success: callback with array containg OrderData
    ///   - error: callback with error, for the sake of simplicity not used in this example - e.g. if no data is received
    
    public static func getOrderData(success: (OrderData) -> Void, error: (Error) -> Void) {
        let arrDeliveryTimesData = [DeliveryTimeData(timeId: "1", name: "Morning"),
                                                        DeliveryTimeData(timeId: "2", name: "Afternoon")]
        let arrCards = [CardData(cardId: "1", cardNumber: "111 11** *** 1111", cardName: "My Card 1"),
                        CardData(cardId: "2", cardNumber: "2222 22** **** 2222", cardName: "My Card 2")]
        
        let orderData = OrderData(deliveryTimes: arrDeliveryTimesData, cards: arrCards)
        
        success(orderData)
    }
    
    /// Fake service invoker for sending order
    ///
    /// - Parameters:
    ///   - data - dictionary (KeyValue type) of prepared request data
    ///   - success: callback with OrderedData
    ///   - error: callback with error, for the sake of simplicity not used in this example - e.g. problem with response data
    
    public static func sendOrder(data: [String: String], success: (OrderedData)-> Void, error: (Error) -> Void) {
        //order sent, received serialized object or some sort of response
        let orderedData = OrderedData(fuelType: data["fuelType"] ?? "",
                                      timeOfDelivery: data["deliveryTimeName"] ?? "",
                                      price: data["fuelPrice"] ?? "",
                                      cardNumber: data["cardNumber"] ?? "")
        success(orderedData)
    }
}
