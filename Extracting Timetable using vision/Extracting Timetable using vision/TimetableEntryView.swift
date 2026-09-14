//
//  TimetableEntryView.swift
//  Extracting Timetable using vision
//
//  Created by Sagar Jangra on 07/11/2025.
//


/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Displays the timetable in a grid.
*/

import SwiftUI

/// A view that displays a single timetable entry.
struct TimetableEntryView: View {
    let entry: TimetableEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(entry.subject).font(.system(size: 10, weight: .bold))
            Text(entry.faculty).font(.system(size: 9))
            HStack {
                Text(entry.room).font(.system(size: 9))
                Spacer()
                Text(entry.group ?? "").font(.system(size: 9))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(4)
        .background(Color.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

/// A view that lays out the entire timetable in a grid.
struct TimetableView: View {
    let slots: [TimeSlot]
    let entries: [TimetableEntry]
    
    private let days = DayOfWeek.allCases
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Grid(alignment: .topLeading, horizontalSpacing: 2, verticalSpacing: 2) {
                // First Header Row (Periods)
                GridRow {
                    Text("Day")
                        .font(.headline)
                        .frame(width: 40)
                        .padding(8)
                    
                    ForEach(slots) { slot in
                        Text(slot.period)
                            .font(.headline)
                            .frame(minWidth: 100)
                            .padding(4)
                    }
                }
                
                // Second Header Row (Times)
                GridRow {
                    Text("Time")
                        .font(.caption)
                        .frame(width: 40)
                        .padding(8)
                    
                    ForEach(slots) { slot in
                        Text(slot.time)
                            .font(.caption)
                            .frame(minWidth: 100, alignment: .center)
                            .padding(4)
                    }
                }
                .background(Color.gray.opacity(0.1))
                
                // Main Timetable Body
                ForEach(days) { day in
                    GridRow(alignment: .top) {
                        Text(day.rawValue)
                            .font(.headline)
                            .frame(width: 40, minHeight: 60, alignment: .center)
                            .padding(8)
                        
                        // Use a while loop to handle column spans correctly
                        var currentColumn = 1
                        while currentColumn <= slots.count {
                            let period = String(currentColumn)
                            
                            if let entry = findEntry(for: day, period: period) {
                                // Found an entry, display it and span columns
                                TimetableEntryView(entry: entry)
                                    .gridCellColumns(entry.columnSpan)
                                
                                // Advance the column index by the span of the entry
                                currentColumn += entry.columnSpan
                            } else {
                                // No entry, draw an empty cell
                                Color.clear
                                    .frame(minHeight: 60)
                                
                                // Advance the column index by 1
                                currentColumn += 1
                            }
                        }
                    }
                    .background(Color.gray.opacity(0.05))
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 5)
            .padding()
        }
        .navigationTitle("Timetable")
    }
    
    /// Helper function to find a timetable entry for a specific day and period.
    private func findEntry(for day: DayOfWeek, period: String) -> TimetableEntry? {
        return entries.first { $0.day == day && $0.timeSlotPeriod == period }
    }
}

#Preview {
    // Sample data for previewing the timetable layout
    let sampleSlots = [
        TimeSlot(period: "1", time: "9:10-10:05"),
        TimeSlot(period: "2", time: "10:05-10:55"),
        TimeSlot(period: "3", time: "11:00-11:50"),
        TimeSlot(period: "4", time: "11:55-12:45"),
        TimeSlot(period: "5", time: "12:45-13:25"),
        TimeSlot(period: "6", time: "13:25-14:15"),
        TimeSlot(period: "7", time: "14:20-15:10"),
        TimeSlot(period: "8", time: "15:15-16:05"),
        TimeSlot(period: "9", time: "16:10-17:00")
    ]
    
    let sampleEntries = [
        // Monday
        TimetableEntry(day: .mo, timeSlotPeriod: "1", subject: "Exploratory Data Analytics", faculty: "Dr. Mukta", room: "D-312 C", group: "Group 1", columnSpan: 1),
        TimetableEntry(day: .mo, timeSlotPeriod: "2", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-124", group: "Group 2", columnSpan: 1),
        TimetableEntry(day: .mo, timeSlotPeriod: "5", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-311", group: nil, columnSpan: 2),

        // Tuesday
        TimetableEntry(day: .tu, timeSlotPeriod: "3", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-301", group: nil, columnSpan: 1),
        TimetableEntry(day: .tu, timeSlotPeriod: "4", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-413 A", group: nil, columnSpan: 1),
        TimetableEntry(day: .tu, timeSlotPeriod: "6", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-122", group: "Group 1", columnSpan: 1),
        TimetableEntry(day: .tu, timeSlotPeriod: "7", subject: "Exploratory Data Analytics", faculty: "Dr. Mukta", room: "D-312 A (IT Lab)", group: "Group 2", columnSpan: 1),
        
        // Thursday
        TimetableEntry(day: .th, timeSlotPeriod: "1", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-312 A (IT Lab)", group: "Group 1", columnSpan: 1),
        TimetableEntry(day: .th, timeSlotPeriod: "2", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-312 B", group: "Group 2", columnSpan: 1),
        TimetableEntry(day: .th, timeSlotPeriod: "4", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-413 A", group: nil, columnSpan: 1),
        TimetableEntry(day: .th, timeSlotPeriod: "6", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-311", group: nil, columnSpan: 1),
        
        // Friday
        TimetableEntry(day: .fr, timeSlotPeriod: "2", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-311", group: nil, columnSpan: 1),
        TimetableEntry(day: .fr, timeSlotPeriod: "4", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-108", group: "Group 1", columnSpan: 1),
        TimetableEntry(day: .fr, timeSlotPeriod: "5", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-122", group: "Group 2", columnSpan: 1),
        TimetableEntry(day: .fr, timeSlotPeriod: "6", subject: "Exploratory Data Analytics", faculty: "Dr. Mukta", room: "D-311", group: nil, columnSpan: 1),
        TimetableEntry(day: .fr, timeSlotPeriod: "7", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-301", group: nil, columnSpan: 1)
    ]
    
    return NavigationStack {
        TimetableView(slots: sampleSlots, entries: sampleEntries)
    }
}