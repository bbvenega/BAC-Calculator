//
//  User.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import Foundation

// User class: Object that holds information about each user's health info
class User: ObservableObject{
    
    @Published var weight: Double
    @Published var measurement: String
    @Published var isMale: Bool
    @Published var Drinks: [Drink] = []
    
    
    
    init(weight: Double = 70.0, measurement: String = "lb", isMale: Bool = true, Drinks: [Drink] = [] ) {
        self.weight = weight
        self.measurement = measurement
        self.isMale = isMale
        self.Drinks = Drinks
    }
}
