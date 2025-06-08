//
//  TaskRowView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 08/06/2025.
//


import SwiftUI
struct TaskRowView: View {
    let task: Task
    let timeSlot: TimeSlot
    @ObservedObject var taskManager: TaskManager
    
    var body: some View {
        HStack {
            Button(action: {
                taskManager.toggleTask(in: timeSlot, taskId: task.id)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? timeSlot.color : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .secondary : .primary)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

