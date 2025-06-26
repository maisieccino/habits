//
//  DataController.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import SwiftData
import HabitsShared

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            modelContainer = try ModelContainer(for: Habit.self, configurations: config)
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for habit in Habit.SampleData {
            context.insert(habit)
        }
    }
    
    var habit: Habit {
        Habit.SampleData.first!
    }
}
