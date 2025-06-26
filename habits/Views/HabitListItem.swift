//
//  HabitListItem.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import SwiftUI
import SwiftData
import HabitsShared

struct HabitListItem: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var habit: Habit
    
    @State
    private var showDetails = false
    
    
    var body: some View {
        DisclosureGroup(isExpanded: $showDetails) {
            VStack(alignment:.leading) {
                Text("Added " + habit.dateAdded.formatted(date: .abbreviated, time: .omitted))
                    .italic()
                    .foregroundStyle(.secondary)
                Toggle("Enable notifications", isOn: $habit.notificationsEnabled.animation())
                NavigationLink{
                   HabitDetail(habit:habit)
                } label: {
                    Text("Edit")
                }
                .foregroundStyle(.blue)
            }
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .fontWeight(.semibold)
                    Text("Daily")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                if !habit.notificationsEnabled {
                    Image(systemName: "bell.slash.fill")
                        .foregroundStyle(.secondary)
                        .transition(.symbolEffect)
                }
            }
        }
    }
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    init(habit: Habit, showDetails: Bool) {
        self.habit = habit
        self._showDetails = State(initialValue: showDetails)
    }
}

#Preview("Collapsed") {
    NavigationStack{
        ZStack{
            Color(.secondarySystemBackground)
            VStack {
                List {
                    HabitListItem(habit: SampleData.shared.habit, showDetails: false)
                }
            }
        }
    }
}

#Preview("Expanded") {
    NavigationStack{
        ZStack{
            Color(.secondarySystemBackground)
            VStack {
                List {
                    HabitListItem(habit: SampleData.shared.habit, showDetails: true)
                }
            }
        }
    }
}
