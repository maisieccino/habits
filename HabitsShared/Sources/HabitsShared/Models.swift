// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import SwiftData
import SwiftUI

public enum HabitSchedule: String,CaseIterable,Identifiable, Codable, Sendable {
    case morning = "Morning"
    case lunchtime = "Lunchtime"
    case evening = "Evening"
    case nightTime = "Night time"
    public var id: Self { self }
}

public let ScheduleGradients: [HabitSchedule: (Color,Color)] = [
    .morning: (Color.red, Color.orange),
    .lunchtime: (Color.blue, Color.green),
    .evening: (Color.indigo, Color.orange),
    .nightTime: (Color.purple, Color.blue)
]

@Model
public final class Habit: Identifiable {
    public var id = UUID()
    public var name: String
    
    public var schedule: HabitSchedule
    
    public var dateAdded: Date
    
    public var notificationsEnabled = false
    
    @Transient
    public var recurrence: Calendar.RecurrenceRule?
    
    // Converts the frequency to a human-readable string.
    func frequencyString() -> String {
        switch self.recurrence?.frequency {
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
        case .none:
            "Unknown"
        @unknown default:
            "Unknown"
        }
    }
    
    convenience init(name: String) {
        self.init(name:name, schedule: .evening)
    }
    
    public init(name: String, schedule: HabitSchedule) {
        self.name = name
        self.schedule = schedule
        self.recurrence = Calendar.RecurrenceRule(
            calendar:Calendar.current,
            frequency: .daily
            )
        self.dateAdded = Date.now
    }
    
    @MainActor public static let SampleData = [
        Habit(name: "Make a coffee", schedule: .morning),
        Habit(name: "Brush teeth")
    ]
}
