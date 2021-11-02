//
//  OrderedViewModel.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 01.11.2021..
//

import Foundation

class OrderedViewModel {
    public var title = "View order"
    
    public var btnTitle = "Cancel"
    
    public var orderedData: OrderedData
    
    public var tableData = [[String: String]]()
    
    public var delegate: MainCoordinatorDelegate?
    
    init(orderedData: OrderedData, delegate: MainCoordinatorDelegate) {
        self.orderedData = orderedData
        self.delegate = delegate
        prepareTableData()
    }
    
    private func prepareTableData() {
        tableData.append(["Fuel Type": orderedData.fuelType])
        tableData.append(["Price": orderedData.price])
        tableData.append(["Time of delivery": orderedData.timeOfDelivery])
        tableData.append(["Card number": orderedData.cardNumber])
    }
    
    public func didTapCancel() {
        delegate?.didTapeCancel()
    }
}
