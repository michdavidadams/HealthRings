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
            ZStack {
                Group {
                    PercentageRing(
                        ringWidth: 35, percent: healthStore.energyPercentage ?? 0 ,
                        backgroundColor: nutritionGreenOne.opacity(0.2),
                        foregroundColors: [nutritionGreenOne, nutritionGreenTwo]
                    )
                        .frame(width: 300, height: 300)
                        .previewLayout(.sizeThatFits)
                }
                Group {
                    PercentageRing(
                        ringWidth: 35, percent: healthStore.stepsPercentage ?? 0 ,
                        backgroundColor: activityRedOne.opacity(0.2),
                        foregroundColors: [activityRedOne, .orange]
                    )
                        .frame(width: 220, height: 220)
                        .previewLayout(.sizeThatFits)
                }
                Group {
                    PercentageRing(
                        ringWidth: 35, percent: healthStore.waterPercentage ?? 0 ,
                        backgroundColor: nutritionGrayOne.opacity(0.2),
                        foregroundColors: [nutritionGrayOne, nutritionGreenOne]
                    )
                        .frame(width: 140, height: 140)
                        .previewLayout(.sizeThatFits)
                }
            }
            Text("Energy: \(healthStore.energyTotal)")
            Text("Steps: \(healthStore.stepsValue ?? standard)")
            Text("Water: \(healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0)")
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
