//
//  TimeSlotTab.swift
//  taskManagementApp
//
//  Created by 田中正造 on 08/06/2025.
//


import SwiftUI
struct TimeSlotTab: View {
    let timeSlot: TimeSlot
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: timeSlot.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : timeSlot.color)
                
                Text(timeSlot.rawValue)
                    .font(.caption)
                    .foregroundStyle(isSelected ? .white : .primary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? timeSlot.color : Color.clear)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
