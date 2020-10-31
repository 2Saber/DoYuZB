//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by saber on 2020/10/31.
//

import Foundation

extension Date {
    static func getCurrent() -> String {
        let nowDate = Date()
        let timeInterval = Int(nowDate.timeIntervalSince1970)
        return "\(timeInterval)"
    }
}
