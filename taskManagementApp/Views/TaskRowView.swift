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
        Button(action: {
            taskManager.toggleTask(in: timeSlot, taskId: task.id)
        }) {
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isCompleted ? timeSlot.color : .gray)
                    .font(.title2)
                Text(task.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .strikethrough(task.isCompleted)
                    .foregroundStyle(task.isCompleted ? .secondary : .primary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.vertical, 4)
    }
}

#Preview {
    let previewTask = Task(title: "aa", isCompleted: false)
    let previewTimeSlot = TimeSlot.morning
    let previewTaskManager = TaskManager()
    
    TaskRowView(
        task: previewTask,
        timeSlot: previewTimeSlot,
        taskManager: previewTaskManager
    )
}
