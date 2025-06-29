//
//  dataModel.swift
//  taskManagementApp
//
//  Created by 田中正造 on 25/05/2025.
//

import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
}

enum TimeSlot: String, CaseIterable ,Codable,Identifiable {
    var id: Self{self}
    case morning = "朝 (6:00-12:00)"
    case afternoon = "昼 (12:00-18:00)"
    case evening = "夜 (18:00-24:00)"
    case lateNight = "深夜 (24:00-6:00)"
    
    var icon: String {
        switch self {
        case .morning: return "sunrise.fill"
        case .afternoon: return "sun.max.fill"
        case .evening: return "sunset.fill"
        case .lateNight: return "moon.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .morning: return .orange
        case .afternoon: return .yellow
        case .evening: return .purple
        case .lateNight: return .blue
        }
    }
}

struct DailyTasks: Codable, Identifiable {
    var id = UUID()
    var date: Date
    private var tasksBySlot: [TimeSlot: [Task]]
    
    init(id:UUID = UUID(),date:Date) {
        self.id = id
        self.date = date
        self.tasksBySlot = [:]
        for slot in TimeSlot.allCases{
            tasksBySlot[slot] = []
        }
    }
    func tasks(for slot :TimeSlot) -> [Task] {
        return tasksBySlot[slot] ?? []
    }
    
    mutating func addTask(_ task:Task ,to slot: TimeSlot) {
        tasksBySlot[slot]?.append(task)
    }
    mutating func deleteTask(in slot:TimeSlot,taskId: UUID) {tasksBySlot[slot]?.removeAll { $0.id == taskId }
    }
    
    mutating func toggleTask(in slot: TimeSlot, taskId: UUID){
        if let index = tasksBySlot[slot]?.firstIndex(where: { $0.id == taskId }) {
            tasksBySlot[slot]?[index].isCompleted.toggle()
        }
    }
}
