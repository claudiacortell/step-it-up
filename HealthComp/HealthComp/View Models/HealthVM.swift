//
//  HealthVM.swift
//  HealthComp
//
//  Created by Claudia Cortell on 11/11/23.
//

import Foundation
import HealthKit



class HealthVM: ObservableObject {
    static let shared = HealthVM()

    var healthStore = HKHealthStore()

    @Published var healthData = HealthData(dailyStep: 0, dailyMileage: 0, dailyFlights: 0, weeklyStep: 0, weeklyMileage: 0)
    
    init() {
        requestAuthorization()
    }
    
    
    func requestAuthorization() {
        //types of data we're reading
        let toReads = Set([
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!,
        ])
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("health data not available!")
            return
        }
        
        //check for authorization
        if healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .stepCount)!) == .notDetermined ||
            healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!) == .notDetermined || healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .flightsClimbed)!) == .notDetermined
        {
            
            //request permission
            healthStore.requestAuthorization(toShare: nil, read: toReads) { success, error in
                if success {
                    self.fetchAllHealthData()
                } else {
                    print("\(String(describing: error))")
                }
            }
        } else {
            //Authorization already granted, fetch data
            self.fetchAllHealthData()
        }
    }
    
    func fetchAllHealthData() {
        readTodaysSteps()
        readWeeklySteps()
        readTodaysMileage()
        readWeeklyMileage()
        readTodaysFlights()
        print("Fetched all health data")
    }
    
    
    func readTodaysSteps() {
        print("READING TODAYS STEPS")
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
            print("steps is \(steps)")
            self.healthData.dailyStep = steps
        }
        healthStore.execute(query)
    }
    
    
    func readWeeklySteps(){
        print("READING WEEKLY STEPS")
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
            print("Weekly steps from \(startOfWeek) to \(endOfWeek): \(steps)")
            self.healthData.weeklyStep = steps
        }
        healthStore.execute(query)
    }
    
    
    func readTodaysMileage(){
        print("READING TODAY'S WALKING/ RUNNING DISTANCE")
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
//            let distanceInKilometers = distanceInMeters / 1000.0 // Convert meters to kilometers if needed
            let distanceInMiles = distanceInMeters * 0.000621371 // Convert meters to miles
        
            self.healthData.dailyMileage = distanceInMiles
            print("Walking/Running distance is \(distanceInMiles) mi")
        }
        healthStore.execute(query)
    }
    
    
    func readWeeklyMileage(){
        print("READING WEEKLY MILAGE")
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
//            let weeklyDistanceInKilometers = weeklyDistanceInMeters / 1000.0 // Convert meters to kilometers if needed
            let weeklyDistanceInMiles = weeklyDistanceInMeters * 0.000621371 // Convert meters to miles
            self.healthData.weeklyMileage = weeklyDistanceInMiles
            print("Weekly mileage from \(startOfWeek) to \(endOfWeek): \(weeklyDistanceInMiles) mi")
        }
        healthStore.execute(query)
    }
    
    
    func readTodaysFlights(){
        print("READING TODAYS FLIGHTS")
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
            print("flights is \(flights)")
            self.healthData.dailyFlights = flights
        }
        healthStore.execute(query)
    }
    
    
}

