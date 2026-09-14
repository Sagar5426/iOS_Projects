//
//  DayOfWeek.swift
//  Extracting Timetable using vision
//
//  Created by Sagar Jangra on 07/11/2025.
//


/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Provides data models to store timetable information.
*/

import Foundation

/// Represents the days of the week in the timetable.
enum DayOfWeek: String, CaseIterable, Hashable, Identifiable {
    case mo = "Mo"
    case tu = "Tu"
    case we = "We"
    case th = "Th"
    case fr = "Fr"
    
    var id: String { self.rawValue }
}

/// Represents a time slot (a column header) in the timetable.
struct TimeSlot: Hashable, Identifiable {
    let id: String
    let period: String
    let time: String
    
    init(period: String, time: String) {
        self.id = period
        self.period = period
        self.time = time
    }
}

/// Represents a single class entry in the timetable.
struct TimetableEntry: Hashable, Identifiable {
    let id = UUID()
    let day: DayOfWeek
    let timeSlotPeriod: String // The starting period number, e.g., "1"
    let subject: String
    let faculty: String
    let room: String
    let group: String?
    let columnSpan: Int // How many columns this entry spans
}