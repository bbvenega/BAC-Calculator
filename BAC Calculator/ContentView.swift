//
//  ContentView.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import SwiftUI

struct ContentView: View {

    // User Health Info
    @State private var isMale: Bool = true
    @State private var weight: Double = 0.0
    @State private var selectedWeightUnit: String = "kg"
    
    //Drink to Add Info
    @State private var volume: Double = 0.0
    @State private var selectedMeasurement = "ml"
    @State private var alcoholContent: Double = 0.0
    @State private var dateSelected: Date = Date()

    // Drinks on given calcuation, and BAC
    @State private var userBAC: Double = 0
    @State private var drinks: [Drink] = []
    
    // Arrays holding the different measurements required
    let weightUnits = ["kg", "lb"]
    let measurements = ["ml", "l", "oz (US)", "pt (US)", "cup (US)", "oz (UK)", "pt (UK)", "cup (UK)"]
    
    
    var body: some View {
        VStack {
            Text("Blood Alcohol Content Calculator")
                .font(.headline)
                .padding()
            
            // This VStack holds health information required from the user for calculation
            VStack {
                
                // Holds the buttons that user selects between male and female
                // Changes the water content for BAC calulation
                HStack {
                    
                    // Male button
                    Button(action: {
                        isMale = true
                    }) {
                        Text("Male")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isMale == true ? Color.blue : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .foregroundColor(isMale == true ? Color.white : Color.blue)
                    }
                    
                    // Female button
                    Button(action: {
                        isMale = false
                    }) {
                        Text("Female")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isMale == false ? Color.pink : Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                // Where user enters weight
                HStack {
                    Text("Weight")
                    TextField("Enter weight", value: $weight, formatter: NumberFormatter.decimalFormatter)
                        .keyboardType(.decimalPad)
                    
                    Picker("Select a Measurement", selection: $selectedWeightUnit) {
                        ForEach(weightUnits, id: \.self) {
                            unit in Text(unit)
                        }
                    }
                    .padding()
                }
            }
            
            // VStack holding the contents for drinks to be added to list
            VStack {
                
                // This HStack holds the volume of the drink to be added
                HStack{
                    Text("Volume: ")
                    TextField("Enter Volume ", value: $volume, formatter: NumberFormatter.decimalFormatter)
                        .keyboardType(.decimalPad)
                    Picker("Select a Measuremennt", selection: $selectedMeasurement) {
                        ForEach(measurements, id: \.self) {
                            measurement in Text(measurement)
                        }
                    }
                }
                
                // Holds content for getting alc content % for this drink to be added
                HStack{
                    Text("Alcohol Content %")
                    TextField("Enter Alcohol Content %", value: $alcoholContent, formatter: NumberFormatter.decimalFormatter)
                        .keyboardType(.decimalPad)
                }
                
                // Date picker for logging drink times
                DatePicker(selection: $dateSelected, label: { Text("Time") })
            }
            .padding()
            
            
            // VStack holding add / calculate buttons & The BAC calculation itself
            VStack {
                
                // Add Drink to List button
                Button(action: {
                    let Drink = Drink(volume: volume, alcoholContent: alcoholContent, timeConsumed: dateSelected, measurement: selectedMeasurement )
                    drinks.append(Drink)
                }) {
                    Text("Add Drink")
                        .cornerRadius(10)
                }
                .padding()
                
                // Calculate Button
                Button(action: {
                    userBAC = calculateBAC(
                        drinks: drinks,
                        bodyWeightKg: (selectedWeightUnit == "kg" ? weight : weight * 0.453592),
                        isMale: isMale,
                        currentTime: dateSelected
                    )
                }) {
                    Text("Calculate BAC")
                        .cornerRadius(10)
                }
                .padding()
                
                // Display of calculation
                Text("Your BAC is currently : \(userBAC, specifier: "%.2f")")
            }
            
            
            // Display the User Added Drinks
            VStack {
                Text("Drinks List")
                    .font(.headline)
                    .padding()
                
                List(drinks) {
                    drink in
                    VStack(alignment: .leading) {
                        Text("Volume: \(drink.volume, specifier: "%.1f") \(drink.measurement)")
                        Text("Alcohol Content: \(drink.alcoholContent, specifier: "%.1f")%")
                        Text("Time Consumed: \(drink.timeConsumed.formatted(date: .abbreviated, time: .shortened))")
                    }
                }
            }
            .padding()

        }
        .padding()
    }
    

    
    // Helper function that converts all drinks into list into ml, based on alcohol content
    func calculateTotalAlc(drinks: [Drink]) -> Double {
        var totalAlc: Double = 0.0
        
        
        // Switch case: handles conversion based on what user inputted for drink
        for drink in drinks {
            let volumeInMl: Double
            
            switch drink.measurement {
            case "ml": volumeInMl = drink.volume
            
            case "l": volumeInMl = drink.volume * 1000
                
            case "oz (US)": volumeInMl = drink.volume * 29.5735
                
            case "pt (US)": volumeInMl = drink.volume * 473.176
            
            case "cup (US)": volumeInMl = drink.volume * 240
            
            case "oz (UK)": volumeInMl = drink.volume * 28.4131
            
            case "pt (UK)": volumeInMl = drink.volume * 568.261
                
            case "cup (UK)": volumeInMl = drink.volume * 284.131
                
            default:
                return 0.0
            }
            
            // Adds each drink, in the converted form and with alcohol content in mind, to total alcohol
            let alcoholGrams = volumeInMl * drink.alcoholContent * 0.789
            totalAlc += alcoholGrams
        }
        return totalAlc
    }
    
    // Helper function to calculate
    func calculateBAC(drinks: [Drink], bodyWeightKg: Double, isMale: Bool, currentTime: Date) -> Double {
        
        // Determines body water by sex of user
        let bodyWaterConstant = isMale ? 0.58 : 0.49
        
        // Standard rate of alcohol elimination by hour
        let alcoholEliminationRate = 0.015
        
        
        let bodyWeightGrams = bodyWeightKg * 1000
        
        let totalAlcGrams = calculateTotalAlc(drinks: drinks)
        
        // If Drinks isn't empty, get earliest drink and set that to first consumed.
        guard let firstDrinkTime = drinks.map({$0.timeConsumed}).min() else {
            return 0.0
        }
        
        // Get the time elapsed of the first drink based on previous calc
        let timeElapsedHours =
        currentTime.timeIntervalSince(firstDrinkTime) / 3600.0
        
        // Use these values to get bac
        let bac = (totalAlcGrams / (bodyWeightGrams * bodyWaterConstant)) - (alcoholEliminationRate * timeElapsedHours)
        
        // Returns non-negative value
        return max(0, bac)
    }
}

extension NumberFormatter {
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }
}

#Preview {
    ContentView()
}
