//
//  SwiftUIView.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 08/04/23.
//

import SwiftUI

extension Date{
    
    func extractDateTimeFromISO8601String(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let time = timeFormatter.string(from: date!)

        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date!)

        let dateTimeString = "\(formattedDate) \(time)"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateTimeString)
    }
}


struct DateTimeView: View {
    let dateTimeString: String
    let date = Date()
    
    var body: some View {
        if let dateTime = date.extractDateTimeFromISO8601String(dateTimeString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            let formattedDateTime = dateFormatter.string(from: dateTime)
            return Text(formattedDateTime).font(.custom("Hoefler Text", size: 14)).foregroundColor(.black)
        } else {
            return Text("Invalid date/time string")
        }
    }
}
