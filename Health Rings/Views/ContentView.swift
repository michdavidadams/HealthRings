//
//  ContentView.swift
//  Health Rings
//
//  Created by Michael Adams on 11/28/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject var healthStore = HealthStore()
    var standard = HKQuantity(unit: HKUnit(from: ""), doubleValue: 0.0)
    //    @State var energyTotal = ((healthStore.activeValue?.doubleValue(for: .kilocalorie())) ?? 0 + (healthStore.restingValue?.doubleValue(for: .kilocalorie()) ?? 0) - (healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0)
    
    var body: some View {
        VStack {
            ZStack {
                ActivityRingView(progress: (healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0) / 2000.00,
                                 ringRadius: 140.0,
                                 thickness: 35.0,
                                 startColor: greenTwo,
                                 endColor: greenOne,
                                 iconName: "leaf")
                ActivityRingView(progress: (healthStore.stepsValue?.doubleValue(for: .count()) ?? 0) / 10000.00,
                                 ringRadius: 103.0,
                                 thickness: 35.0,
                                 startColor: yellowTwo,
                                 endColor: yellowOne,
                                 iconName: "pawprint")
                ActivityRingView(progress: (healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0) / 80.00,
                                 ringRadius: 66.0,
                                 thickness: 35.0,
                                 startColor: blueTwo,
                                 endColor: blueOne,
                                 iconName: "drop")
                
            }
            .frame(height:350)
            Spacer().frame(height:50)
            
            Text("Energy: \((healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0).formatted())")
            Text("Steps: \(healthStore.stepsValue ?? standard)")
            Text("Water: \((healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0).formatted())")
        }.onAppear {
            healthStore.setUpHealthStore()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
