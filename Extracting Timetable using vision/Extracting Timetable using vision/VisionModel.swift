//
//  to.swift
//  Extracting Timetable using vision
//
//  Created by Sagar Jangra on 07/11/2025.
//


/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Provides a class to detect and parse a table containing contact information.
*/

import SwiftUI
import Vision
import DataDetection

@Observable
class VisionModel {
    
    enum AppError: Error {
        case noDocument
        case noTable
        case invalidPoint
    }
    
    /// The first table detected in the document.
    var table: DocumentObservation.Container.Table? = nil
    
    // MARK: - Contact Parsing Properties
    /// A list of contacts extracted from the table.
    var contacts = [Contact]()
    
    // MARK: - Timetable Parsing Properties
    /// A list of parsed timetable entries.
    var timetableEntries = [TimetableEntry]()
    /// A list of parsed time slots from the header.
    var timeSlots = [TimeSlot]()
    
    /// A flag to determine which parsing logic to run.
    var parseAsTimetable: Bool = false
    
    /// Run Vision document recognition on the image to parse a table.
    func recognizeTable(in image: Data) async {
        resetState()
        do {
            let table = try await extractTable(from: image)
            self.table = table
            
            // Branching logic to decide which parser to use
            if parseAsTimetable {
                (self.timeSlots, self.timetableEntries) = parseTimetable(table)
            } else {
                self.contacts = parseTable(table)
            }
            
        } catch {
            print(error)
        }
    }
    
    /// Clear data from previous table detection.
    func resetState() {
        self.table = nil
        self.contacts = []
        self.timetableEntries = []
        self.timeSlots = []
    }
    
    /// Convert a simple table into a TSV string format compatible with pasting into Notes & Numbers.
    ///
    /// Simple tables have at most 1 line per cell, and no cells that span multiple rows or columns.
    func exportTable() async throws -> String {
        guard let rows = self.table?.rows else {
            throw AppError.noTable
        }
        // Map each row into a tab-delimited line.
        let tableRowData = rows.map { row in
            return row.map({ $0.content.text.transcript }).joined(separator: "\t")
        }
        // Create a multiline string with one row per line.
        return tableRowData.joined(separator: "\n")
    }

    /// Process an image and return the first table detected.
    private func extractTable(from image: Data) async throws -> DocumentObservation.Container.Table {
        
        // The Vision request.
        let request = RecognizeDocumentsRequest()
        
        // Perform the request on the image data and return the results.
        let observations = try await request.perform(on: image)

        // Get the first observation from the array.
        guard let document = observations.first?.document else {
            throw AppError.noDocument
        }
        
        // Extract the first table detected.
        guard let table = document.tables.first else {
            throw AppError.noTable
        }
        
        return table
    }
    
    /// Extract name, email addresses, and phone number from a table into a list of contacts.
    private func parseTable(_ table: DocumentObservation.Container.Table) -> [Contact] {
        var contacts = [Contact]()
        
        // Iterate over each row in the table.
        for row in table.rows {
            // The contact name will be taken from the first column.
            guard let firstCell = row.first else {
                continue
            }
            // Extract the text content from the transcript.
            let name = firstCell.content.text.transcript
            
            // Look for emails and phone numbers in the remaining cells.
            var detectedPhone: String? = nil
            var detectedEmail: String? = nil
            
            for cell in row.dropFirst() {
                // Get all detected data in the cell, then match emails and phone numbers.
                for data in cell.content.text.detectedData {
                    switch data.match.details {
                    case .emailAddress(let email):
                        detectedEmail = email.emailAddress
                    case .phoneNumber(let phoneNumber):
                        detectedPhone = phoneNumber.phoneNumber
                    default:
                        break
                    }
                }
            }
            
            // Create a contact if an email was detected.
            if let email = detectedEmail {
                let contact = Contact(name: name, email: email, phoneNumber: detectedPhone)
                contacts.append(contact)
            }
        }
    
        return contacts
    }
    
    // MARK: - New Timetable Parsing Function (Stub)
    
    /// Extract timetable data from a table.
    private func parseTimetable(_ table: DocumentObservation.Container.Table) -> ([TimeSlot], [TimetableEntry]) {
        var slots = [TimeSlot]()
        var entries = [TimetableEntry]()
        
        // --- PARSING LOGIC TO BE IMPLEMENTED LATER ---
        // This is where the complex logic will go.
        // 1. Iterate the first few rows to find the time slots (e.g., "1", "9:10-10:05").
        //    This will populate the `slots` array.
        // 2. Iterate the main data rows (e.g., "Mo", "Tu", ...).
        // 3. For each data cell, read its `rowIndex`, `columnIndex`, `rowSpan`, and `colSpan`.
        // 4. Use these coordinates to map the cell to a `DayOfWeek` and `TimeSlot`.
        // 5. Read the cell's transcript (e.g., "Software Engineering\nDr. Urvashi\nD-311")
        //    and split it to create a `TimetableEntry`.
        // 6. The `columnSpan` property from the `cell` is critical for handling
        //    merged cells (like the 2-hour "Software Engineering" class).
        
        print("Timetable parsing logic not yet implemented.")
        
        // For now, I will return the SAMPLE DATA from the TimetableView
        // so you can see the app working with the new view.
        // In the final version, this logic would be replaced by the real parser.
        
        slots = [
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
        
        entries = [
            TimetableEntry(day: .mo, timeSlotPeriod: "1", subject: "Exploratory Data Analytics", faculty: "Dr. Mukta", room: "D-312 C", group: "Group 1", columnSpan: 1),
            TimetableEntry(day: .mo, timeSlotPeriod: "2", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-124", group: "Group 2", columnSpan: 1),
            TimetableEntry(day: .mo, timeSlotPeriod: "5", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-311", group: nil, columnSpan: 2),
            TimetableEntry(day: .tu, timeSlotPeriod: "3", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-301", group: nil, columnSpan: 1),
            TimetableEntry(day: .tu, timeSlotPeriod: "4", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-413 A", group: nil, columnSpan: 1),
            TimetableEntry(day: .tu, timeSlotPeriod: "6", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-122", group: "Group 1", columnSpan: 1),
            TimetableEntry(day: .tu, timeSlotPeriod: "7", subject: "Exploratory Data Analytics", faculty: "Dr. Mukta", room: "D-312 A (IT Lab)", group: "Group 2", columnSpan: 1),
            TimetableEntry(day: .th, timeSlotPeriod: "1", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-312 A (IT Lab)", group: "Group 1", columnSpan: 1),
            TimetableEntry(day: .th, timeSlotPeriod: "2", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-312 B", group: "Group 2", columnSpan: 1),
            TimetableEntry(day: .th, timeSlotPeriod: "4", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-413 A", group: nil, columnSpan: 1),
            TimetableEntry(day: .th, timeSlotPeriod: "6", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-311", group: nil, columnSpan: 1),
            TimetableEntry(day: .fr, timeSlotPeriod: "2", subject: "Machine Learning-1", faculty: "Dr. Alpana Jija", room: "D-311", group: nil, columnSpan: 1),
            TimetableEntry(day: .fr, timeSlotPeriod: "4", subject: "Software Engineering", faculty: "Dr. Urvashi", room: "D-108", group: "Group 1", columnSpan: 1),
            TimetableEntry(day: .fr, timeSlotPeriod: "5", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-122", group: "Group 2", columnSpan: 1),
            TimetableEntry(day: .fr, timeSlotPeriod: "6", subject: "Exploratory Data Analytics", faculty: "Dr. Mukta", room: "D-311", group: nil, columnSpan: 1),
            TimetableEntry(day: .fr, timeSlotPeriod: "7", subject: "Artificial Intelligence", faculty: "Dr. Meenakshi", room: "D-301", group: nil, columnSpan: 1)
        ]
        
        return (slots, entries)
    }
}

extension DocumentObservation.Container.Table {
    /// Returns the contents of cell that a user clicked on.
    func cell(at point: NormalizedPoint) -> TableCell? {
        let visionPoint = point.cgPoint
        // Verify the point falls inside the bounding region of the table.
        guard self.boundingRegion.normalizedPath.contains(visionPoint) else {
            return nil
        }
        // Inspect each cell.
        for row in self.rows {
            for cell in row {
                // Check if the point falls inside the cell.
                if cell.content.boundingRegion.normalizedPath.contains(visionPoint) {
                    return TableCell(cell)
                }
            }
        }
        return nil
    }
}