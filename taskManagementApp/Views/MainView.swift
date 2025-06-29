//
//  ContentView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 24/05/2025.
//

import SwiftUI



struct MainView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var selectedTimeSlot: TimeSlot = .morning
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ToggleDayView(taskManager: taskManager)
                    .frame(height: 60)
                
                TimeSlotTabView(selectedTimeSlot: $selectedTimeSlot)
                
                TaskListView(
                    timeSlot: selectedTimeSlot,
                    taskManager: taskManager
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(
                    timeSlot: selectedTimeSlot,
                    taskManager: taskManager,
                    isPresented: $showingAddTask
                )
            }
        }
    }
}

#Preview {
    MainView()
}
