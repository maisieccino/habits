//
//  HabitModel.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import Foundation
import SwiftData


@Model
final class Habit: Identifiable {
    var id = UUID()
    var name: String
    
    var frequency: Calendar.RecurrenceRule.Frequency
    
    var dateAdded: Date
    
    var notificationsEnabled = false
    
    @Transient
    var recurrence: Calendar.RecurrenceRule?
    
    // Converts the frequency to a human-readable string.
    func frequencyString() -> String {
        switch self.frequency {
        case .minutely:
            "Every minute"
        case .hourly:
            "Hourly"
        case .daily:
            "Daily"
        case .weekly:
            "Weekly"
        case .monthly:
            "Monthly"
        case .yearly:
            "Yearly"
        @unknown default:
            "Unknown"
        }
    }
    
    convenience init(name: String) {
        self.init(name:name, frequency: .daily)
    }
    
    init(name: String, frequency: Calendar.RecurrenceRule.Frequency) {
        self.name = name
        self.frequency = frequency
        self.recurrence = Calendar.RecurrenceRule(
            calendar:Calendar.current,
            frequency: Calendar.RecurrenceRule.Frequency.daily
            )
        self.dateAdded = Date.now
    }
    
    static let SampleData = [
        Habit(name: "Make a coffee", frequency: .weekly),
        Habit(name: "Brush teeth")
    ]
}
