//
//  TaskListView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 08/06/2025.
//


import SwiftUI
struct TaskListView: View {
    let timeSlot: TimeSlot
    @ObservedObject var taskManager: TaskManager
    
    var tasks: [Task] {
        taskManager.tasks[timeSlot] ?? []
    }
    
    var body: some View {
        VStack {
            // 進捗表示
            ProgressView(value: taskManager.getCompletionRate(for: timeSlot))
                .progressViewStyle(LinearProgressViewStyle(tint: timeSlot.color))
                .padding()
            
            if tasks.isEmpty {
                EmptyStateView(timeSlot: timeSlot)
            } else {
                List {
                    ForEach(tasks) { task in
                        TaskRowView(
                            task: task,
                            timeSlot: timeSlot,
                            taskManager: taskManager
                        )
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            taskManager.deleteTask(
                                in: timeSlot,
                                taskId: tasks[index].id
                            )
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}
