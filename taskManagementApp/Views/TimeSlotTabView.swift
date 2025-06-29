//
//  TimeSlotTabView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 08/06/2025.
//

import SwiftUI
struct TimeSlotTabView: View {
    @Binding var selectedTimeSlot: TimeSlot
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(TimeSlot.allCases, id: \.self) { slot in
                    TimeSlotTab(
                        timeSlot: slot,
                        isSelected: selectedTimeSlot == slot
                    ) {
                        selectedTimeSlot = slot
                    }
                }
            }
            .padding(.horizontal)
        }
        .scaledToFit()
        .background(.regularMaterial)
    }
}
