//
//  Drink.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import Foundation

// Drink class: Object that holds information about each user-added drink
class Drink: Identifiable{
    let id = UUID()
    var volume: Double
    var alcoholContent: Double
    var timeConsumed: Date
    var measurement: String
    
    init(volume: Double, alcoholContent: Double, timeConsumed: Date, measurement: String) {
        self.volume = volume
        self.alcoholContent = alcoholContent
        self.timeConsumed = timeConsumed
        self.measurement = measurement
    }
}
