//
//  Friends.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import SwiftUI

// Will eventually serve as the main hub for content
struct Friends: View {
    var body: some View {
        NavigationStack {
            
            //VStack holds renavigation buttons for calculation and user edit
            VStack {
                Text("Welcome to the Friends")
                    .font(.headline)
                    .padding()

            }
        }
    }
}

#Preview {
    Friends()
        .environmentObject(User(weight: 70, measurement: "lbs", isMale: true, Drinks: []))
}

