//
//  TaskTileView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 13.10.26.
//

import SwiftUI

struct TaskTileView: View {
    let task: Task
    var onTap: (() -> Void)? = nil
    
    var daysLeftText: String? {
        guard let days = task.daysLeft else { return nil }
        switch days {
        case ..<0: return "Atrasada \(-days)d"
        case 0:    return "Hoje"
        case 1:    return "Amanhã"
        default:   return "\(days) dias"
        }
    }
    
    var body: some View {
        CommonCard(onTap: onTap) {
            HStack(spacing: 12){
                CircleProgressView(
                     progress: task.progress,
                     color: task.priority.color,
                )
                
                VStack(alignment: .leading){
                    Text(task.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    
                    if let note = task.note {
                        Text(note)
                            .font(.footnote.weight(.light))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                    }
                }
                Spacer()
                if let days = daysLeftText {
                    Text(days)
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .padding(.leading, 8)
                }
            }
        }
    }
}

#Preview {
    TaskTileView(task: Task.samples.last!)
}
