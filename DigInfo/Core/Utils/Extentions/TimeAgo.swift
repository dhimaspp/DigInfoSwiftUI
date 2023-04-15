//
//  TimeAgo.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 08/04/23.
//

import SwiftUI

struct TimeAgoView: View {
    var date: Date
    
    var body: some View {
        Text("\(timeAgoSinceDate(date))")
    }
    
    func timeAgoSinceDate(_ date: Date, numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = now < date ? now : date
        let latest = earliest == now ? date : now
        let components = calendar.dateComponents([.minute, .hour, .day, .weekOfYear, .month, .year], from: earliest, to: latest)
        
        if let year = components.year, year > 0 {
            return year == 1 ? "1 year ago" : "\(year) years ago"
        }
        if let month = components.month, month > 0 {
            return month == 1 ? "1 month ago" : "\(month) months ago"
        }
        if let week = components.weekOfYear, week > 0 {
            return week == 1 ? "1 week ago" : "\(week) weeks ago"
        }
        if let day = components.day, day > 0 {
            return day == 1 ? "1 day ago" : "\(day) days ago"
        }
        if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        }
        if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        }
        return "Just now"
    }
}
