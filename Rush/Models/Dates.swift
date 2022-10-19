//
//  Dates.swift
//  Rush
//
//  Created by Michael Gillund on 10/11/22.
//

import SwiftUI

struct Dates {
    
    struct Day: Identifiable {
        var id = UUID()
        let value: Date
        let tag: Int
    }
    
    static let today: Int = Dates.global[4].tag
    
    static let global: [Day] = [
        Day(value: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, tag: 0),
        Day(value: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, tag: 1),
        Day(value: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, tag: 2),
        Day(value: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, tag: 3),
        Day(value: Date(), tag: 4),
        Day(value: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, tag: 5),
        Day(value: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, tag: 6),
        Day(value: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, tag: 7),
        Day(value: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, tag: 8),
    ]
     static let tabs: [Tabs] = [
        .init(title: Dates.global[0].value.formatDates()),
        .init(title: Dates.global[1].value.formatDates()),
        .init(title: Dates.global[2].value.formatDates()),
        .init(title: Dates.global[3].value.formatDates()),
        .init(title: Dates.global[4].value.formatDates()),
        .init(title: Dates.global[5].value.formatDates()),
        .init(title: Dates.global[6].value.formatDates()),
        .init(title: Dates.global[7].value.formatDates()),
        .init(title: Dates.global[8].value.formatDates()),
    ]
}
struct Tabs {
    var title: String
}
