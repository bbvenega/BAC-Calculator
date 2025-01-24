//
//  BAC_CalculatorApp.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import SwiftUI

@main


struct BAC_CalculatorApp: App {
    @StateObject private var user = User()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
