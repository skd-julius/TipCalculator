//
//  ContentView.swift
//  TipCalculation
//
//  Created by Skd Julius on 4/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var enteredAmount: String = ""
    @State private var tipAmount: Double = 0
    @State private var totalAmount: Double = 0
    @State private var tipSlider: Double = 15

    
    var body: some View {
        VStack {
            Text("Enter bill amount")
                .foregroundColor(.secondary)
            
            TextField("0.00", text: $enteredAmount)
                .multilineTextAlignment(.center)
                .font(.system(size: 70, weight: .semibold, design: .rounded))
                .keyboardType(.decimalPad)
            
            Text("Tip: \(tipSlider) %")
            
            Slider(value: $tipSlider, in: 1...100, step: 1)
                .onChange(of: tipSlider, { oldValue, newValue in
                    guard let amount = Double(enteredAmount) else {
                        print("Invalid entry")
                        return
                    }
                    
                    guard let tip = Calculation().calculateTip(of: amount, with: tipSlider) else {
                        print("Bill amount or tip cannot be negative")
                        return
                    }
                    tipAmount = tip
                    totalAmount = amount + tipAmount
                })
            VStack {
                Text(tipAmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                Text("Tip amount")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.top, 20)
            
            VStack {
                Text(totalAmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                Text("Total amount")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.top, 20)
        }
        .padding(30)
    }
}

//#Preview {
//    ContentView()
//}

struct Calculation {
    func calculateTip(of enteredAmount: Double, with tip: Double) -> Double? {
        let tipPercentage = tip / 100
        return enteredAmount * tipPercentage
    }
}
