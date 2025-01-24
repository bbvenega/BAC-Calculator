//
//  mainMenu.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import SwiftUI

// Will eventually serve as the main hub for content
struct mainMenu: View {
    var body: some View {
        NavigationStack {
            
            //VStack holds renavigation buttons for calculation and user edit
            VStack {
                Text("Welcome to the First Page")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: ContentView()) {
                    Text("Go to Calc")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: EditUser()) {
                    Text("Go to Edit User")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    mainMenu()
        .environmentObject(User(weight: 70, measurement: "lbs", isMale: true, Drinks: []))
}

