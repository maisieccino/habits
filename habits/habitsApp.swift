//
//  habitsApp.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import SwiftUI
import SwiftData
import HabitsShared

@main
struct habitsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Habit.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HabitsList()
        }
        .modelContainer(sharedModelContainer)
    }
}
