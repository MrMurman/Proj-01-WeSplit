//
//  ContentView.swift
//  Proj-01-WeSplit
//
//  Created by Андрей Бородкин on 06.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotalLocal = checkAmount + tipValue
        let amountPerPerson = grandTotalLocal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotalLocal = checkAmount + tipValue
        
        return grandTotalLocal
    }
    
    var currencyString: String {
        return Locale.current.currency?.identifier ?? "USD"
    }
    
    var body: some View {
        
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do u want to leave")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: currencyString))
                } header: {
                    Text("Grand total amoun")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyString))
                } header: {
                    Text("Amount per person")
                }
                
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
