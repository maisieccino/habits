//
//  Habits.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import SwiftUI
import SwiftData
import HabitsShared

struct HabitsList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    
    @State private var newHabit: Habit?
    
    var body: some View {
        let filterSchedules = HabitSchedule.allCases.filter {s in habits.contains(where:{$0.schedule == s})}
        
        NavigationSplitView {
            List(filterSchedules) {schedule in
                Section(header: Text(schedule.rawValue)) {
                    ForEach(habits.filter {$0.schedule == schedule}) { habit in
                        HabitListItem(habit:habit)
                    }
                }
            }
            .navigationTitle("All habits")
            .toolbar {
                ToolbarItem {
                    Button("Add habit", systemImage: "plus", action: addHabit)
                }
            }
        } detail: {
            Text("Select a habit")
        }
        .sheet(item: $newHabit) { habit in
            NavigationStack {
                HabitDetail(habit: habit)
            }
            .presentationDetents([.medium, .large])
        }
    }
    
    private func addHabit() {
        let newHabit = Habit(name: "Something", schedule: .evening)
        modelContext.insert(newHabit)
        self.newHabit = newHabit
    }
        
}

#Preview {
    HabitsList()
        .modelContainer(SampleData.shared.modelContainer)
}
