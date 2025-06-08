//
//  ContentView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 24/05/2025.
//

import SwiftUI


class TaskManager: ObservableObject {
    @Published var tasks: [TimeSlot: [Task]] = [:]
    
    init() {
        
        for slot in TimeSlot.allCases {
            tasks[slot] = []
        }
    }
    
    func addTask(to timeSlot: TimeSlot, title: String) {
        let newTask = Task(title: title)
        tasks[timeSlot]?.append(newTask)
    }
    
    func toggleTask(in timeSlot: TimeSlot, taskId: UUID) {
        if let index = tasks[timeSlot]?.firstIndex(where: { $0.id == taskId }) {
            tasks[timeSlot]?[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(in timeSlot: TimeSlot, taskId: UUID) {
        tasks[timeSlot]?.removeAll {
            $0.id == taskId }
    }
    
    func getCompletionRate(for timeSlot: TimeSlot) -> Double {
        guard let slotTasks = tasks[timeSlot], !slotTasks.isEmpty else { return 0 }
        let completedCount = slotTasks.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(slotTasks.count)
    }
}


struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var selectedTimeSlot: TimeSlot = .morning
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 時間帯選択タブ
                TimeSlotTabView(selectedTimeSlot: $selectedTimeSlot)
                
                // タスクリスト
                TaskListView(
                    timeSlot: selectedTimeSlot,
                    taskManager: taskManager
                )
            }
            .navigationTitle("TaskForce")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
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
        .navigationViewStyle(.stack)
    }
}







#Preview {
    ContentView()
}
