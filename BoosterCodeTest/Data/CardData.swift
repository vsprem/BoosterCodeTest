//
//  CardData.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 01.11.2021..
//

import Foundation

class CardData {
    public var cardId: String
    public var cardNumber: String
    public var cardName: String
    
    init(cardId: String, cardNumber: String, cardName: String) {
        self.cardId = cardId
        self.cardNumber = cardNumber
        self.cardName = cardName
    }
}
