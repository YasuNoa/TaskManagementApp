//
//  TaskManager.swift
//  taskManagementApp
//
//  Created by 田中正造 on 13/06/2025.
//

import SwiftUI


class TaskManager: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var allDailyTasks:[DailyTasks] = []
    
    private let tasksKey = "tasks_by_timeslot"
    
    init() {
        load()
    }
    
    private func getIndexForSelectedDate() -> Int {
        let dataToFind = Calendar.current.startOfDay(for: self.selectedDate)
        if let index = allDailyTasks.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: dataToFind) }) {
            return index
        }else{
            let newDailyTasks = DailyTasks(date: dataToFind)
            allDailyTasks.append(newDailyTasks)
            return allDailyTasks.count - 1
        }
    }
    
    func tasksForSelectedDate(in slot :TimeSlot) -> [Task] {
        guard !allDailyTasks.isEmpty else { return [] }
        let selectedDaysIndex = getIndexForSelectedDate()
        return allDailyTasks[selectedDaysIndex].tasks(for: slot)
    }
    
    func addTask(to timeSlot: TimeSlot, title: String) {
        let newTask = Task(title: title)
        let index = getIndexForSelectedDate()
        allDailyTasks[index].addTask(newTask, to: timeSlot)
        save()
    }
    
    func toggleTask(in timeSlot: TimeSlot, taskId: UUID) {
        let index = getIndexForSelectedDate()
        allDailyTasks[index].toggleTask(in :timeSlot, taskId: taskId)
        save()
    }
    
    func deleteTask(in timeSlot: TimeSlot, taskId: UUID) {
        let index = getIndexForSelectedDate()
        allDailyTasks[index].deleteTask(in: timeSlot, taskId: taskId)
        save()
    }
    
    func getCompletionRate(for timeSlot: TimeSlot) -> Double {
        guard !allDailyTasks.isEmpty else { return 0.0 }
        let selectedDaysIndex = getIndexForSelectedDate()
        let selectedDaysTasks =  allDailyTasks[selectedDaysIndex]
        let slotTasks = selectedDaysTasks.tasks(for: timeSlot)
        guard !slotTasks.isEmpty else { return 0 }
        let completedCount = slotTasks.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(slotTasks.count)
    }
    
    private func save(){
        if let encodedData = try? JSONEncoder().encode(allDailyTasks) {
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
        }
    }
    
    private func load() {
        if let savedData = UserDefaults.standard.data(forKey: tasksKey),
           let decodedTasks = try?
            JSONDecoder().decode([DailyTasks].self, from: savedData) {
            self.allDailyTasks = decodedTasks
        }else{
            self.allDailyTasks = []
        }
    }
    
    func goToPreviousDay() {
        if let newDate = Calendar.current.date(byAdding:.day , value: -1, to: selectedDate) {
            selectedDate = newDate
        }
    }
    
    func goToNextDay() {
        if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
            selectedDate = newDate
            
        }
    }
}




