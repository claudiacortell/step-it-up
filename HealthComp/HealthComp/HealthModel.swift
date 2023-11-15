//
//  HealthModel.swift
//  HealthComp
//
//  Created by Phillip Le on 11/14/23.
//

import Foundation
import HealthKit

extension Date {
    static var startDayYesterday: Date {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        return Calendar.current.startOfDay(for: yesterday)
    }
}


class HealthManager: ObservableObject{
    @Published var data: HealthData = HealthData()
    let healthStore = HKHealthStore()
    
    init(){
        let steps = HKQuantityType(.stepCount)
        let healthTypes: Set = [steps]
        
        Task{
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("error")
            }
        }
    }
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startDayYesterday, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else{
                print (error?.localizedDescription)
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            DispatchQueue.main.async{
                self.data.dailyStep = Int(stepCount)
            }
        }
        healthStore.execute(query)
    }
}
