//
//  ContentView.swift
//  WeSplit
//
//  Created by Alice Nedosekina on 23/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount: String = ""
    @State private var guestNumber: Int = 0
    @State private var tipPercent: Int = 0
    
    
    var perPerson: (sum: String, topay: String) {
        guard billAmount != "" else{
            return (sum: "Enter amount", topay: "0.0")
        }
        
        guard let totalBill = Double(billAmount) else {
            return (sum: "Bill amount is not valid", topay: "0.0")
        }
        
        let sum: Double = totalBill + totalBill * Double(tips[tipPercent])/100
        
        let guests: Double = Double(guestNumber + 2)
        
        let toPay: Double = round( ( sum / guests ) * 100 ) / 100
        
        return (sum: "Total to pay \(sum)", topay: "\(toPay)")
    }
    
    
    var tips = [0, 10 , 15, 20, 25]
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                
                Form{
                   
                    Section (header: Text("Bill details")) {
                        
                        Picker("Number of people", selection: $guestNumber) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                            }
                        }
                        TextField("Total bill amount", text: $billAmount)
                            .keyboardType(.decimalPad)
                    }
                    
                    
                    
                    
                    Section (header: Text("Tip percentage")){
                    
                        Picker("Tip percent", selection: $tipPercent) {
                            ForEach (0 ..< tips.count) {
                                Text("\(self.tips[$0])%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                    }
                
                    
                }
                
                
                //Calculation result
                
                Spacer()
                    .frame(height: 40.0)
                    
                VStack{
                    Text("\(perPerson.sum)")
                        .font(.title2)
                    Spacer()
                        .frame(height: 40.0)
                       
                    Text("£ \(perPerson.topay)")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("per person")
                }
                Spacer()
                    .frame(height: 40.0)
            }
            .navigationBarTitle("Split bill")
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
