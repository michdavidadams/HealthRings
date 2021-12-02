//
//  HealthStore.swift
//  Health Rings
//
//  Created by Michael Adams on 11/28/21.
//

import Foundation
import HealthKit

class HealthStore: ObservableObject {
    var healthStore: HKHealthStore?
    var query: HKStatisticsQuery?
    
    // Steps
    @Published var stepsValue: HKQuantity?
    
    // Energy
    @Published var dietaryValue: HKQuantity?
    @Published var activeValue: HKQuantity?
    @Published var restingValue: HKQuantity?
    
    // Water
    @Published var waterValue: HKQuantity?
    
    // Protein
    @Published var proteinValue: HKQuantity?
    
    // Fiber
    @Published var fiberValue: HKQuantity?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func setUpHealthStore() {
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryWater)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryFiber)!
        ]
        healthStore?.requestAuthorization(toShare: nil, read: typesToRead, completion: { success, error in
            if success {
                print("--> requestAuthorization")
                self.calculateSteps()
                self.calculateEnergies()
                self.calculateWater()
                self.calculateProtein()
                self.calculateFiber()
            }
        })
    }
    
    // MARK: - Calculate steps
    func calculateSteps() {
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the step count ***")
        }
        
        // Today predicate
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        query = HKStatisticsQuery(quantityType: steps,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.stepsValue = statistics?.sumQuantity()
                print("----> calculateSteps statistics: \(String(describing: statistics))")
                print("----> calculateSteps error: \(String(describing: error))")
                print("----> calculateSteps: \(String(describing: self.stepsValue))")
            }
        }
        healthStore!.execute(query!)
    }
    
    // MARK: - Calculate energy sums
    func calculateEnergies() {
        guard let dietary = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the dietary energy count ***")
        }
        guard let active = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the active energy count ***")
        }
        guard let resting = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the resting energy count ***")
        }
        
        // Today predicate
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        // Dietary energy sum
        query = HKStatisticsQuery(quantityType: dietary,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.dietaryValue = statistics?.sumQuantity()
                print("----> dietary energy statistics: \(String(describing: statistics))")
                print("----> dietary energy error: \(String(describing: error))")
                print("----> dietary energy: \(String(describing: self.dietaryValue))")
            }
        }
        healthStore!.execute(query!)
        
        // Active energy sum
        query = HKStatisticsQuery(quantityType: active,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.activeValue = statistics?.sumQuantity()
                print("----> active energy statistics: \(String(describing: statistics))")
                print("----> active energy error: \(String(describing: error))")
                print("----> active energy: \(String(describing: self.activeValue))")
            }
        }
        healthStore!.execute(query!)
        
        // Resting energy sum
        query = HKStatisticsQuery(quantityType: resting,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.restingValue = statistics?.sumQuantity()
                print("----> resting energy statistics: \(String(describing: statistics))")
                print("----> resting energy error: \(String(describing: error))")
                print("----> resting energy: \(String(describing: self.restingValue))")
            }
        }
        healthStore!.execute(query!)
    }
    
    // MARK: - Calculate water intake
    func calculateWater() {
        guard let water = HKObjectType.quantityType(forIdentifier: .dietaryWater) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the water intake count ***")
        }
        
        // Today predicate
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        query = HKStatisticsQuery(quantityType: water,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.waterValue = statistics?.sumQuantity()
                print("----> water statistics: \(String(describing: statistics))")
                print("----> water error: \(String(describing: error))")
                print("----> water: \(String(describing: self.waterValue))")
            }
        }
        healthStore!.execute(query!)
    }
    
    // MARK: - Calculate protein intake
    func calculateProtein() {
        guard let protein = HKObjectType.quantityType(forIdentifier: .dietaryProtein) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the protein intake count ***")
        }
        
        // Today predicate
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        query = HKStatisticsQuery(quantityType: protein,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.proteinValue = statistics?.sumQuantity()
                print("----> protein statistics: \(String(describing: statistics))")
                print("----> protein error: \(String(describing: error))")
                print("----> protein: \(String(describing: self.proteinValue))")
            }
        }
        healthStore!.execute(query!)
    }
    
    // MARK: - Calculate fiber intake
    func calculateFiber() {
        guard let fiber = HKObjectType.quantityType(forIdentifier: .dietaryFiber) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the fiber intake count ***")
        }
        
        // Today predicate
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        query = HKStatisticsQuery(quantityType: fiber,
                                  quantitySamplePredicate: predicate,
                                  options: .cumulativeSum) {
            query, statistics, error in
            DispatchQueue.main.async{
                self.fiberValue = statistics?.sumQuantity()
                print("----> fiber statistics: \(String(describing: statistics))")
                print("----> fiber error: \(String(describing: error))")
                print("----> fiber: \(String(describing: self.fiberValue))")
            }
        }
        healthStore!.execute(query!)
    }
    
}
