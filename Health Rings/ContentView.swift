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
    
    var body: some View {
        
        VStack {
            Text("Steps: \(healthStore.stepsValue ?? standard)")
            Text("Energy: \(healthStore.energyTotal.rounded(), specifier: "%.0f")")
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
