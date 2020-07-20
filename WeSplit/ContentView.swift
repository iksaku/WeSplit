//
//  ContentView.swift
//  WeSplit
//
//  Created by Jorge Gonzalez on 18/07/20.
//  Copyright © 2020 iksaku. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalWithTip: Double {
        // Calculate the total check amount
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }

    var totalPerPerson: Double {
        // Calculate total amount per person
        let peopleCount = Double(numberOfPeople) ?? 0

        if (peopleCount < 1) {
            return 0;
        }

        return totalWithTip / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Check Amount")
                        TextField("0.00", text: $checkAmount)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Number of People")
                        TextField("0", text: $numberOfPeople)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                    }
                }

                Section {
                    HStack {
                        Text("Tip Amount").padding(.trailing, 20)
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(0 ..< tipPercentages.count, id: \.self) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }

                Section {
                    HStack {
                        Text("Total Amount (With Tip)")
                        Text("$\(totalWithTip, specifier: "%.2f")")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    HStack {
                        Text("Total per Person")
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
