//
//  EmptyStateView.swift
//  taskManagementApp
//
//  Created by 田中正造 on 08/06/2025.
//

import SwiftUI

struct EmptyStateView: View {
    let timeSlot: TimeSlot
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: timeSlot.icon)
                .font(.system(size: 50))
                .foregroundColor(timeSlot.color.opacity(0.5))
            
            Text("\(timeSlot.rawValue)のタスクがありません")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("右上の + ボタンでタスクを追加してください")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
