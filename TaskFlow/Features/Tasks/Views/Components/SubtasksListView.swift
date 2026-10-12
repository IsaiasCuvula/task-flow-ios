//
//  SubtasksListView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import SwiftUI
import SwiftData

struct SubtasksListView: View {
    @Environment(\.modelContext) private var modelContext
    let task: Task
    
    var body: some View {
        VStack{
            
            if task.subtasks.isEmpty {
                ContentUnavailableView("empty_tasks", systemImage: "list.bullet.indent")
            }else{
                VStack(spacing: 12) {
                    ForEach(task.subtasks){ subtask in
                            
                        HStack(spacing: 8){
                            Button{
                                subtask.isCompleted.toggle()
                            } label: {
                                Image(systemName:subtask.isCompleted ? "checkmark.app.fill" : "app")
                                    .font(.title3)
                                    .foregroundStyle(subtask.isCompleted  ?  AnyShapeStyle(.tint) : AnyShapeStyle(.secondary))
                            }
                            .buttonStyle(.plain)
                            
                            Text(subtask.title)
                                .font(.title3)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}

//#Preview {
//    SubtasksListView()
//}
