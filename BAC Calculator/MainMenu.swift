//
//  mainMenu.swift
//  BAC Calculator
//
//  Created by Brian Venegas on 1/23/25.
//

import SwiftUI







let specificDate = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 14))!
// Will eventually serve as the main hub for content
struct mainMenu: View {
    
@State private var selectedDate: DateComponents?

    @EnvironmentObject var user: User
    var body: some View {
        
        

        
        NavigationStack {
            

            VStack {
                CalendarView(selectedDate: $selectedDate)
                    .frame(height: 400)
                    .padding()
                
                

 
                
                // VStack holds interactive calendar
                VStack {
                    //Converts the selected date into same format as drink class
                    if let selectedDate = selectedDate,
                       let selectedDateAsDate = Calendar.current.date(from: selectedDate) { // Convert DateComponents to Date

                        let filteredDrinks = user.Drinks.filter { drink in
                            Calendar.current.isDate(drink.timeConsumed, inSameDayAs: selectedDateAsDate)
                        }

                        if filteredDrinks.isEmpty {
                            Text("No drinks recorded for this date.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(filteredDrinks) { drink in
                                Text("\(drink.volume, specifier: "%.2f") \(drink.measurement) - \(drink.alcoholContent, specifier: "%.1f")%")
                            }

                        }
                    } else {
                        Text("Select a date to view drinks.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                NavigationLink(destination: ContentView()) {
                    Text("Calc")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            NavigationLink(destination: EditUser()) {
                                Text("Edit User")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                            
                            NavigationLink(destination: Friends()) {
                                Text("Friends")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: Event()) {
                                Text("Event")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                            
                        }
                        
                    }
                }

            }
        }
    }
}

#Preview {
    mainMenu()
        .environmentObject(User(weight: 70, measurement: "lbs", isMale: true, Drinks: [
            Drink(volume: 12.0, alcoholContent: 5.0, timeConsumed: specificDate, measurement: "oz"),
            Drink(volume: 24.0, alcoholContent: 5.0, timeConsumed: specificDate, measurement: "oz"),
            Drink(volume: 16.0, alcoholContent: 7.5, timeConsumed: Date(), measurement: "oz"), // Today’s date
            Drink(volume: 50.0, alcoholContent: 33.0, timeConsumed: Date(), measurement: "ml") // Today’s date
        ]))
}

