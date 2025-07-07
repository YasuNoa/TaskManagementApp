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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日(E)"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                toggleDayView
                    .frame(height: 60)
                
                timeSlotTabView
                
                taskListView
                
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
    @ViewBuilder
    private var toggleDayView: some View {
        
        HStack(spacing: 60) {
            Button {
                taskManager.goToPreviousDay()
            }label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            Spacer()
            
            Text(dateFormatter.string(from:taskManager.selectedDate))
                .font(.headline)
            Spacer()
            
            Button(action: {
                taskManager.goToNextDay()
            }){
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
        .padding()
    }
    @ViewBuilder
    private var timeSlotTabView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(TimeSlot.allCases, id: \.self) { slot in
                    timeSlotTab(for: slot)
                }
            }
            .padding(.horizontal)
        }
        .frame(height:80)
        .background(.regularMaterial)
    }
    @ViewBuilder
    private var taskListView:some View {
        let tasks =
        taskManager.tasksForSelectedDate(in: selectedTimeSlot)
        
        VStack {
            ProgressView(value: taskManager.getCompletionRate(for: selectedTimeSlot))
                .progressViewStyle(LinearProgressViewStyle(tint: selectedTimeSlot.color))
                .padding()
            
            if tasks.isEmpty {
                EmptyStateView(timeSlot: selectedTimeSlot)
            } else {
                List {
                    ForEach(tasks) { task in
                        TaskRowView(
                            task: task,
                            timeSlot: selectedTimeSlot,
                            taskManager: taskManager
                        )
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            taskManager.deleteTask(
                                in: selectedTimeSlot,
                                taskId: tasks[index].id
                            )
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
    private func timeSlotTab(for slot: TimeSlot) -> some View {
        let isSelected = (selectedTimeSlot == slot)
        
        return Button(action:{
            selectedTimeSlot = slot
        }){
            VStack(spacing: 8) {
                Image(systemName: slot.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : slot.color)
                
                Text(slot.rawValue)
                    .font(.caption)
                    .foregroundStyle(isSelected ? .white : .primary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? slot.color : Color.clear)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainView()
}
