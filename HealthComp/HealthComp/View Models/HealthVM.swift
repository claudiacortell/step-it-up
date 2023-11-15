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
    @Published var healthData: HealthData?
    
//    @Published var dailyStep: Int?
//    @Published var dailyMileage: Double?
//    @Published var dailyFlights: Int?
//    @Published var weeklyStep: Int?
//    @Published var weeklyMileage: Double?
    
    
    init() {
        requestAuthorization()
        //writeHealthData()
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
                    let result = self.fetchAllHealthData()
                    switch result {
                        case .success(let returnedHealthData):
                            self.healthData = returnedHealthData
                        case .failure:
                            print("Unable to load health data")
                    }
                } else {
                    print("\(String(describing: error))")
                }
            }
        } else {
            //Authorization already granted, fetch data
            let result = self.fetchAllHealthData()
            switch result {
                case .success(let returnedHealthData):
                    self.healthData = returnedHealthData
                case .failure:
                    print("Unable to load health data")
            }
        }
    }
    
    func fetchAllHealthData() -> HealthKitRetrievalHealthData {
        var fetchedHealthData = HealthData(dailyStep: nil, dailyMileage: nil, dailyFlights: nil, weeklyStep: nil, weeklyMileage: nil)
        let dailyStepResult = readTodaysSteps()
        switch dailyStepResult{
            case .success(let steps):
                fetchedHealthData.dailyStep = steps
            case .failure:
                print("Getting daily steps failed")
            
        }
        
        let weeklyStepResult = readWeeklySteps()
        switch weeklyStepResult{
            case .success(let weeklySteps):
                fetchedHealthData.weeklyStep = weeklySteps
            case .failure:
                print("Getting weekly steps failed")
            
        }
        
        let dailyMileageResult = readTodaysMileage()
        switch dailyMileageResult{
            case .success(let dailyMileage):
                fetchedHealthData.dailyMileage = dailyMileage
            case .failure:
                print("Getting daily mileage failed")
            
        }
        
        let weeklyMileageResult = readWeeklyMileage()
        switch weeklyMileageResult{
            case .success(let weeklyMileage):
                fetchedHealthData.weeklyMileage = weeklyMileage
            case .failure:
                print("Getting weekly mileage failed")
            
        }
   
        let dailyFlightResult = readTodaysFlights()
        switch dailyFlightResult{
            case .success(let dailyFlights):
                fetchedHealthData.dailyFlights = dailyFlights
            case .failure:
                print("Getting daily flights failed")
            
        }

        print("Fetched all health data")
        return .success(fetchedHealthData)
        
    }
    
    
    func readTodaysSteps() -> HealthKitRetrievalInt{
        var steps = 0
        print("READING TODAYS STEPS")
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return .failure
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
            
            steps = Int(sum.doubleValue(for: HKUnit.count()))
            print("Daily steps: \(steps)")
//            self.healthData.dailyStep = steps
        }
        healthStore.execute(query)
        return .success(steps)
    }
    
    
    func readWeeklySteps() -> HealthKitRetrievalInt{
        print("READING WEEKLY STEPS")
        var weeklySteps = 0
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return .failure
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        //Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return .failure
        }
        //Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return .failure
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
//            self.healthData.weeklyStep = steps
            weeklySteps = steps
        }
        healthStore.execute(query)
        return .success(weeklySteps)
    }
    
    
    func readTodaysMileage() -> HealthKitRetrievalDouble{
        var dailyMileage = 0.0
        print("READING TODAY'S WALKING/ RUNNING DISTANCE")
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return .failure
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
        
//            self.healthData.dailyMileage = distanceInMiles
            dailyMileage = distanceInMiles
            print("Daily mileage: \(distanceInMiles) mi")
            
        }
        healthStore.execute(query)
        return .success(dailyMileage)
    }
    
    
    func readWeeklyMileage() -> HealthKitRetrievalDouble{
        print("READING WEEKLY MILAGE")
        var weeklyMileage = 0.0
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return .failure
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        // Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return .failure
        }
        // Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return .failure
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
            weeklyMileage = weeklyDistanceInMiles
//            self.weeklyMileage = weeklyDistanceInMiles
            print("Weekly mileage from \(startOfWeek) to \(endOfWeek): \(weeklyDistanceInMiles) mi")
        }
        healthStore.execute(query)
        return .success(weeklyMileage)
    }
    
    
    func readTodaysFlights() -> HealthKitRetrievalInt{
        print("READING TODAYS FLIGHTS")
        var dailyFlights = 0
        guard let flightsType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            return .failure
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
            print("Daily flights: \(flights)")
            dailyFlights = flights
        }
        healthStore.execute(query)
        return .success(dailyFlights)
    }
    
    
//    func writeHealthData() ->{
//
//    }
    
    
}

