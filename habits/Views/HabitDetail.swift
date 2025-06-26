//
//  habitDetail.swift
//  habits
//
//  Created by Maisie Bell on 26/06/2025.
//

import SwiftUI
import HabitsShared

struct HabitDetail: View {
    @Bindable var habit: Habit
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var isSaved = false
    
    var body: some View {
        let gradient = LinearGradient(
            colors: [
                ScheduleGradients[habit.schedule]!.0,
                ScheduleGradients[habit.schedule]!.1,
            ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
    
        let icon = switch (habit.schedule) {
        case .morning: "sunrise.fill"
        case .lunchtime: "sun.max.fill"
        case .evening: "sunset.fill"
        case .nightTime: "moon.stars.fill"
        }
        
        NavigationView {
            ZStack(alignment:.top) {
                ZStack(alignment:.top) {
                    gradient
                        .ignoresSafeArea(.container, edges:[.top,.horizontal])
                        .frame(width: .infinity,height: 150)
                        .overlay {
                            gradient
                                .blur(radius:20)
                                .padding(-20)
                        }
                    Image(systemName: icon)
                        .foregroundStyle(.white)
                        .offset(x:0, y: 10)
                        .scaleEffect(2)
                        .contentTransition(.symbolEffect(.replace))
                }
                
                Form {
                    Text("Add a habit")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    TextField("Name", text: $habit.name)
                    Picker("Schedule", selection: $habit.schedule.animation(.smooth)) {
                        ForEach(HabitSchedule.allCases) { schedule in
                            Text(schedule.rawValue)
                        }
                    }
                    Toggle("Enable notifications", isOn: $habit.notificationsEnabled)
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 50)
            }
            .padding(.top, -100)
        }
        .toolbar {
            ToolbarItem(placement:.cancellationAction) {
                Button("Cancel") {
                    modelContext.delete(habit)
                    dismiss()
                }
                .foregroundStyle(.white)
            }
            ToolbarItem(placement:.confirmationAction) {
                Button("Save") {
                    isSaved = true
                    dismiss()
                }
                .foregroundStyle(.white)
            }
        }
        .onDisappear {
            if !isSaved {
                modelContext.delete(habit)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HabitDetail(habit:SampleData.shared.habit)
    }
}
