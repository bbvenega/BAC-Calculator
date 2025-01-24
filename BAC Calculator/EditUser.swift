//
//  EditUser.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import SwiftUI

struct EditUser: View {

    
    
    @EnvironmentObject var user: User
    let weightUnits = ["lbs", "kg"]
    
    // Serves as edit user data page
    var body: some View {
        
        NavigationStack {
            // This VStack holds health information required from the user for calculation
            VStack {
                
                // Holds the buttons that user selects between male and female
                // Changes the water content for BAC calulation
                HStack {
                    
                    // Male button
                    Button(action: {
                        user.isMale = true
                    }) {
                        Text("Male")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(user.isMale == true ? Color.blue : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .foregroundColor(user.isMale == true ? Color.white : Color.blue)
                    }
                    
                    // Female button
                    Button(action: {
                        user.isMale = false
                    }) {
                        Text("Female")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(user.isMale == false ? Color.pink : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                // Where user enters weight
                HStack {
                    Text("Weight")
                    TextField("Enter weight", value: $user.weight, formatter: NumberFormatter.decimalFormatter)
                        .keyboardType(.decimalPad)
                    
                    Picker("Select a Measurement", selection: $user.measurement) {
                        ForEach(weightUnits, id: \.self) {
                            unit in Text(unit)
                        }
                    }
                    .padding()
                }
            }
        }
        }
    }


#Preview {
    EditUser()
        .environmentObject(User(weight: 70, measurement: "lbs", isMale: true, Drinks: []))
}

