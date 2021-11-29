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
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black.edgesIgnoringSafeArea(.all)
                ScrollView {
                    ZStack {
                        RingView(
                            percentage: healthStore.waterPercentage ?? 1,
                            backgroundColor: Color.standRingBackground,
                            startColor: Color.standRingStartColor,
                            endColor: Color.standRingEndColor,
                            thickness: Constants.mainRingThickness
                        )
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                        RingView(
                            percentage: healthStore.stepsPercentage ?? 0,
                            backgroundColor: Color.exerciseRingBackground,
                            startColor: Color.exerciseRingStartColor,
                            endColor: Color.exerciseRingEndColor,
                            thickness: Constants.mainRingThickness
                        )
                            .frame(width: 215, height: 215)
                            .aspectRatio(contentMode: .fit)
                        RingView(
                            percentage: healthStore.energyPercentage ?? 0,
                            backgroundColor: Color.moveRingBackground,
                            startColor: Color.moveRingStartColor,
                            endColor: Color.moveRingEndColor,
                            thickness: Constants.mainRingThickness
                        )
                            .frame(width: 280, height: 280)
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }
            }.onAppear {
                healthStore.setUpHealthStore()
                healthStore.calculateSteps()
                healthStore.calculateEnergies()
                healthStore.calculateWater()
            }
            
            //        VStack {
            //            Text("Steps: \(healthStore.stepsValue ?? standard)")
            //            Text("Energy: \(healthStore.energyTotal.rounded(), specifier: "%.0f")")
            //            Text("Energy: \(healthStore.waterValue ?? standard)")
            //        }.onAppear {
            //            healthStore.setUpHealthStore()
            //        }
        }
        
        
        //    func createRings() -> some View {
        //
        //        ZStack {
        //            RingView(
        //                percentage: healthStore.waterPercentage ?? 1,
        //                backgroundColor: Color.standRingBackground,
        //                startColor: Color.standRingStartColor,
        //                endColor: Color.standRingEndColor,
        //                thickness: Constants.mainRingThickness
        //            )
        //                .frame(width: 150, height: 150)
        //                .aspectRatio(contentMode: .fit)
        //            RingView(
        //                percentage: healthStore.stepsPercentage ?? 0,
        //                backgroundColor: Color.exerciseRingBackground,
        //                startColor: Color.exerciseRingStartColor,
        //                endColor: Color.exerciseRingEndColor,
        //                thickness: Constants.mainRingThickness
        //            )
        //                .frame(width: 215, height: 215)
        //                .aspectRatio(contentMode: .fit)
        //            RingView(
        //                percentage: healthStore.energyPercentage ?? 0,
        //                backgroundColor: Color.moveRingBackground,
        //                startColor: Color.moveRingStartColor,
        //                endColor: Color.moveRingEndColor,
        //                thickness: Constants.mainRingThickness
        //            )
        //                .frame(width: 280, height: 280)
        //                .aspectRatio(contentMode: .fit)
        //        }.onTapGesture {
        //            healthStore.calculateSteps()
        //            healthStore.calculateEnergies()
        //            healthStore.calculateWater()
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
