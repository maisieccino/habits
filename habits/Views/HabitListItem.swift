//
//  HabitListItem.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import SwiftUI
import SwiftData

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
                Toggle("Enable notifications", isOn: $habit.notificationsEnabled)
                Button(action: {}) {
                    Text("Edit")
                    .frame(maxWidth:.infinity)
                }
                    .buttonStyle(.bordered)
            }
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .fontWeight(.semibold)
                    Text(habit.frequencyString())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                if !habit.notificationsEnabled {
                    Image(systemName: "bell.slash.fill")
                        .foregroundStyle(.secondary)
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
    ZStack{
        Color(.secondarySystemBackground)
        VStack {
            List {
                HabitListItem(habit: SampleData.shared.habit, showDetails: false)
            }
        }
    }
}

#Preview("Expanded") {
    ZStack{
        Color(.secondarySystemBackground)
        VStack {
            List {
                HabitListItem(habit: SampleData.shared.habit, showDetails: true)
            }
        }
    }
}
