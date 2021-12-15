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
    
    // Detect dark mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            
            // Title and date
            VStack(alignment: .leading) {
                Text(Date(), style: .date)
                    .font(Font.caption.smallCaps())
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Health Rings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            VStack {
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Energy")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                            HStack {
                                Text("\(String(format: "%.0f", (healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0).rounded()))/2000")
                                    .font(.title)
                                Text("CAL")
                                    .font(.title.uppercaseSmallCaps())
                            }
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(Color("Blue 1"))
                        }
                        .padding(.bottom, 0.1)
                        
                        VStack(alignment: .leading) {
                            Text("Protein")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                            
                            HStack {
                                Text("\(String(format: "%.0f", (healthStore.proteinValue?.doubleValue(for: .gram()) ?? 0).rounded()))/115")
                                    .font(.title)
                                Text("G")
                                    .font(.title.uppercaseSmallCaps())
                            }
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(Color("Yellow 1"))
                        }
                        .padding(.bottom, 0.1)
                        
                        VStack(alignment: .leading) {
                            Text("Water")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                            HStack {
                                Text("\(String(format: "%.0f", (healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0).rounded()))/80")
                                    .font(.title)
                                Text("OZ")
                                    .font(.title.uppercaseSmallCaps())
                            }
                            .minimumScaleFactor(0.01)
                            .foregroundColor(Color("Green 1"))
                            .lineLimit(1)
                        }
                    }
                    .padding()
                    
                    ZStack {
                        ActivityRingView(progress: (healthStore.dietaryValue?.doubleValue(for: .kilocalorie()) ?? 0) / 2000.00,
                                         ringRadius: 70.0,
                                         thickness: 17.5,
                                         startColor: blueTwo,
                                         endColor: blueOne,
                                         iconName: "battery.100")
                        ActivityRingView(progress: (healthStore.proteinValue?.doubleValue(for: .gram()) ?? 0) / 115.00,
                                         ringRadius: 51.5,
                                         thickness: 17.5,
                                         startColor: yellowTwo,
                                         endColor: yellowOne,
                                         iconName: "scalemass.fill")
                        ActivityRingView(progress: (healthStore.waterValue?.doubleValue(for: .fluidOunceUS()) ?? 0) / 80.00,
                                         ringRadius: 33.0,
                                         thickness: 17.5,
                                         startColor: greenTwo,
                                         endColor: greenOne,
                                         iconName: "drop.fill")
                        
                        
                    }
                    .padding()
                    Spacer()//.frame(height:50)
                    
                }
                .frame(width: 370.0, height: 200)
                .background(colorScheme == .dark ? Color.gray : Color.black)
                .cornerRadius(10.0)
            }
            
            
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
