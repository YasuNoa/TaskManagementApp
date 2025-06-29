//
//  AddTaskView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 08/06/2025.
//

import SwiftUI


struct AddTaskView: View {
    let timeSlot: TimeSlot
    @ObservedObject var taskManager: TaskManager
    @Binding var isPresented: Bool
    @State private var taskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image(systemName: timeSlot.icon)
                        .font(.system(size: 40))
                        .foregroundColor(timeSlot.color)
                    
                    Text(timeSlot.rawValue)
                        .font(.headline)
                }
                .padding(.top)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("タスク内容")
                        .font(.headline)
                    
                    TextField("タスクを入力してください", text: $taskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("タスク追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("追加") {
                        if !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            taskManager.addTask(to: timeSlot, title: taskTitle)
                            isPresented = false
                        }
                    }
                    .disabled(taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
#Preview {
    AddTaskView(
        timeSlot: .morning,
        taskManager: TaskManager(),
        isPresented: .constant(true)
    )
}
