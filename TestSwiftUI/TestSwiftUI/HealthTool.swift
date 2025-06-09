//
//  HealthTool.swift
//  TestSwiftUI
//
//  Created by Neil on 21/5/25.
//

import HealthKit


class HealthTool: NSObject {
    
    /// 请求权限
    /// - Parameter completion: 回调
    static func requestHealthKitAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, NSError(domain: "HealthKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "HealthKit 不可用"]))
            return
        }

        let healthStore = HKHealthStore()
        
        // 定义要读取的月经相关数据类型
        let typesToRead: Set = [
            HKCategoryType.categoryType(forIdentifier: .menstrualFlow)!,
            HKCategoryType.categoryType(forIdentifier: .cervicalMucusQuality)!,
            HKCategoryType.categoryType(forIdentifier: .ovulationTestResult)!,
            HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!
        ]
        
        // 请求权限
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    /// 获取月经流量数据
    /// - Parameters:
    ///   - startDate: 开始日期
    ///   - endDate: 结束日期
    ///   - completion: 回调
    static func fetchMenstrualFlowData(startDate: Date, endDate: Date, completion: @escaping ([HKCategorySample]?, Error?) -> Void) {
        let healthStore = HKHealthStore()
        
        // 定义月经流量数据类型
        guard let menstrualFlowType = HKCategoryType.categoryType(forIdentifier: .menstrualFlow) else {
            completion(nil, NSError(domain: "HealthKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "月经流量类型不可用"]))
            return
        }
        
        // 创建查询谓词，限定时间范围
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        // 创建样本查询
        let query = HKSampleQuery(sampleType: menstrualFlowType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            // 将样本转换为 HKCategorySample
            let menstrualSamples = samples as? [HKCategorySample]
            completion(menstrualSamples, nil)
        }
        
        // 执行查询
        healthStore.execute(query)
    }
}
