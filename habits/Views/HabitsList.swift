//
//  Habits.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import SwiftUI
import SwiftData

struct HabitsList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    
    var body: some View {
        NavigationSplitView {
            List(habits) {habit in
                HabitListItem(habit: habit)
            }
            .navigationTitle("All habits")
            .toolbar {
                ToolbarItem {
                    Button("Add habit", systemImage: "plus", action: {})
                }
            }
        } detail: {
            Text("Your habits")
        }
    }
        
}

#Preview {
    HabitsList()
        .modelContainer(SampleData.shared.modelContainer)
}
