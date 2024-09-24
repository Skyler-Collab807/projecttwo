//
//  ContentView.swift
//  projecttwo
//
//  Created by Skyler on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var startingTemp = 0.0
    @State private var endingTemp = 0.0
    @State private var startingMeasurement = "Celsius"
    @State private var endingMeasurement = "Celsius"
    
    // For the keyboard
    @FocusState private var amountIsFocused: Bool
    
    let measurements = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedTemp: Double {
        var newTemp = startingTemp
        
        // If starting and ending measurements match return the same value
        if startingMeasurement == "Celsius" && endingMeasurement == "Celsius" {
            return newTemp
        }
        if startingMeasurement == "Fahrenheit" && endingMeasurement == "Fahrenheit" {
            return newTemp
        }
        if startingMeasurement == "Kelvin" && endingMeasurement == "Kelvin" {
            return newTemp
        }
        
        // Skipping Celsius (Converting others to Celsius)
        if startingMeasurement == "Fahrenheit" {
            newTemp = (newTemp - 32) / 1.8
        } else if startingMeasurement == "Kelvin" {
            newTemp = newTemp - 273.15
        }
        
        // Converting from Celsius to Fahrenheit or Kelvin
        if endingMeasurement == "Fahrenheit" {
            newTemp = newTemp * 1.8 + 32
        } else if endingMeasurement == "Kelvin" {
            newTemp = newTemp + 273.15
        }
        
        
        // Returns converted value
        return newTemp
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select a Starting Temperature") {
                    Picker("Temperature Measurement",
                           selection: $startingMeasurement) {
                        ForEach(measurements, id: \.self) {
                            Text($0)
                            
                        }
                    }
                           .pickerStyle(.segmented)
                    
                    TextField("Temperature", value: $startingTemp, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                }
                Section("Select a measurement to convert to"){
                    Picker("Temperature Measurement", selection:
                            $endingMeasurement) {
                        ForEach(measurements, id: \.self) {
                            Text($0)
                        }
                    }
                            .pickerStyle(.segmented)
                    Text(convertedTemp, format: .number)
                }
                }
                .navigationTitle("Temperature Converter")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
    
    

#Preview {
    ContentView()
}
