//
//  HealthVM.swift
//  HealthComp
//
//  Created by Claudia Cortell on 11/11/23.
//

import Foundation
import HealthKit


class HealthVM: ObservableObject {
    var healthStore = HKHealthStore()
    @Published var validData: Bool = false
    @Published var healthData: HealthData = HealthData(){
        didSet {
            if isValid(healthData){
                validData.toggle()
                print("Write")
            }
        }
    }

    // Because the fetching happens asynchronously and each object in the struct gets fetched on its own then we cant make it optional
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let flights = HKQuantityType(.flightsClimbed)
        let healthTypes: Set = [steps, distance, flights]
        
        Task{
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("Error getting permissions from user")
            }
        }
    }
    
     func isValid(_ data: HealthData) -> Bool {
         return data.dailyStep != nil && data.dailyMileage != nil && data.dailyFlights != nil && data.weeklyStep != nil
    }
    
    func fetchAllHealthData() {
        readTodaysSteps()
        readWeeklySteps()
        readTodaysMileage()
        readWeeklyMileage()
        readTodaysFlights()
    }
    
    
    func readTodaysSteps(){
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return 
        }
        
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) {
            _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
                //HAVE A POPUP!!!
                return
            }
            
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            DispatchQueue.main.async{
                self.healthData.dailyStep = steps
            }
        }
        healthStore.execute(query)
    }
    
    
    func readWeeklySteps(){
        var weeklySteps = 0
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        //Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return
        }
        //Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return
        }

        let predicate = HKQuery.predicateForSamples(
          withStart: startOfWeek,
          end: endOfWeek,
          options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
          quantityType: stepCountType,
          quantitySamplePredicate: predicate,
          options: .cumulativeSum
        ) { _, result, error in
          guard let result = result, let sum = result.sumQuantity() else {
            if let error = error {
              print("An error occurred while retrieving weekly step count: \(error.localizedDescription)")
            }
              return
          }
    
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            DispatchQueue.main.async{
                self.healthData.weeklyStep = steps
            }
        }
        healthStore.execute(query)
    }
    
    
    func readTodaysMileage(){
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return
        }
        
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: distanceType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to read walking/running distance: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
                // HANDLE ERROR (e.g., show a popup)
                return
            }

            let distanceInMeters = sum.doubleValue(for: HKUnit.meter())
            let distanceInMiles = distanceInMeters * 0.000621371 // Convert meters to miles
            
            DispatchQueue.main.async{
                self.healthData.dailyMileage = distanceInMiles
            }
        }
        healthStore.execute(query)
    }
    
    
    func readWeeklyMileage(){
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        // Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return
        }
        // Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return
        }

        let predicate = HKQuery.predicateForSamples(
          withStart: startOfWeek,
          end: endOfWeek,
          options: .strictStartDate
        )

        let query = HKStatisticsQuery(
          quantityType: distanceType,
          quantitySamplePredicate: predicate,
          options: .cumulativeSum
        ) { _, result, error in
          guard let result = result, let sum = result.sumQuantity() else {
            if let error = error {
              print("An error occurred while retrieving mileage: \(error.localizedDescription)")
            }
              return
          }
    
            let weeklyDistanceInMeters = sum.doubleValue(for: HKUnit.meter())
            let weeklyDistanceInMiles = weeklyDistanceInMeters * 0.000621371 // Convert meters to miles
            DispatchQueue.main.async{
                self.healthData.weeklyMileage = weeklyDistanceInMiles
            }
        }
        healthStore.execute(query)
    }
    
    
    func readTodaysFlights(){
        guard let flightsType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            return
        }
        
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: flightsType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) {
            _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("failed to read flights: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
                //HAVE A POPUP!!!
                return
            }
            
            let flights = Int(sum.doubleValue(for: HKUnit.count()))
            DispatchQueue.main.async{
                self.healthData.dailyFlights = flights
            }
        }
        healthStore.execute(query)
    }
}

