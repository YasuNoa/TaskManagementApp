//
//  ToggleDayView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 29/06/2025.
//

import SwiftUI

struct ToggleDayView: View {
    @ObservedObject var taskManager: TaskManager
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日(E)"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }
    
    var body: some View {
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
    }
}

#Preview {
    ToggleDayView(taskManager: TaskManager())
}
