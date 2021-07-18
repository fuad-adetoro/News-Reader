//
//  Date+timeAgoDisplay_Ext.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo)s ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)m ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)h ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day)d ago"
        }
        
        return "\(secondsAgo / week) weeks ago"
    }
}
