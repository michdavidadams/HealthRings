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
        ScrollView {
            
            // Title and date
            VStack(alignment: .leading) {
                Text(Date(), style: .date)
                    .font(Font.caption.smallCaps())
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                Text("Summary")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding()
            
            VStack {
                
                // MARK: - Nutrition Rings
                Text("Nutrition")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("Energy")
                                        .font(.subheadline.lowercaseSmallCaps())
                                    HStack {
                                        Text("\(String(format: "%.0f", (healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0).rounded()))/2000")
                                            .font(.title)
                                        Text("CAL")
                                            .font(.title.uppercaseSmallCaps())
                                    }
                                    .minimumScaleFactor(0.01)
                                    .lineLimit(1)
                                    .foregroundColor(Color("Green 1"))
                                }
                                .padding(.bottom, 0.1)
                                
                                VStack(alignment: .leading) {
                                    Text("Protein")
                                        .font(.subheadline.lowercaseSmallCaps())
                                    HStack {
                                        Text("\(String(format: "%.0f", (healthStore.proteinValue?.doubleValue(for: .gram()) ?? 0).rounded()))/115")
                                            .font(.title)
                                        Text("G")
                                            .font(.title.uppercaseSmallCaps())
                                    }
                                    .lineLimit(1)
                                    .foregroundColor(Color("Yellow 1"))
                                }
                                .padding(.bottom, 0.1)
                                
                                VStack(alignment: .leading) {
                                    Text("Water")
                                        .font(.subheadline.lowercaseSmallCaps())
                                    HStack {
                                        Text("\(String(format: "%.0f", (healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0).rounded()))/80")
                                            .font(.title)
                                        Text("OZ")
                                            .font(.title.uppercaseSmallCaps())
                                    }
                                    .foregroundColor(Color("Blue 1"))
                                    .lineLimit(1)
                                }
                            }
                            .padding()
                            
                            ZStack {
                                ActivityRingView(progress: (healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0) / 2000.00,
                                                 ringRadius: 70.0,
                                                 thickness: 17.5,
                                                 startColor: greenTwo,
                                                 endColor: greenOne,
                                                 iconName: "battery.0")
                                ActivityRingView(progress: (healthStore.proteinValue?.doubleValue(for: .gram()) ?? 0) / 115.00,
                                                 ringRadius: 51.5,
                                                 thickness: 17.5,
                                                 startColor: yellowTwo,
                                                 endColor: yellowOne,
                                                 iconName: "scalemass")
                                ActivityRingView(progress: (healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0) / 80.00,
                                                 ringRadius: 33.0,
                                                 thickness: 17.5,
                                                 startColor: blueTwo,
                                                 endColor: blueOne,
                                                 iconName: "drop")
                            
                                
                            }
                            .padding()
                            //.frame(height:200)
                            Spacer()//.frame(height:50)
                        
                        }
                        .frame(width: 370.0, height: 200)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.286, opacity: 0.38))
                        .cornerRadius(10.0)
                    
                
                
            }.onAppear {
                healthStore.setUpHealthStore()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
