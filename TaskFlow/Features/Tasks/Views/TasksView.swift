//
//  TasksView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 9.10.26.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.dueDate) private var allTasks: [Task] = []
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationStack{
            
            if allTasks.isEmpty {
                ContentUnavailableView("empty_tasks", systemImage: "list.bullet.indent")
            }
            
            List {
                ForEach(allTasks){ task in
                    
                        HStack(spacing: 8){
                            Button{
                                task.isCompleted.toggle()
                            } label: {
                                Image(systemName:task.isCompleted ? "checkmark.app.fill" : "app")
                                    .font(.title)
                                    .foregroundStyle(task.isCompleted  ?  AnyShapeStyle(.tint) : AnyShapeStyle(.secondary))
                            }
                            .buttonStyle(.plain)
                           
                            Button{
                                selectedTask = task
                            } label: {
                                VStack(alignment: .leading,spacing: 4){
                                    Text(task.title)
                                        .font(.title3)
                                        .lineLimit(1)
                                    
                                    HStack(spacing: 4){
                                        if let date = task.dueDate{
                                            Text(
                                                date.formatted(date:.abbreviated, time:.omitted))
                                            
                                        }
                                        
                                        if task.dueDate != nil && task.note != nil {
                                            
                                            Text("·")
                                        }
                                        
                                        if let note = task.note{
                                            Text(note)
                                        }
                                    }
                                    .foregroundStyle(.secondary)
                                    .font(.footnote.weight(.regular))
                                    .lineLimit(1)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(.plain)
                       Spacer()
                    }
                        .swipeActions {
                            Button(role: .destructive){
                                withAnimation {
                                    modelContext.delete(task)
                                }
                            } label: {
                                Label("delete", systemImage: "trash")
                            }
                        }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("tasks")
            .sheet(item: $selectedTask) { task in
                TaskDetailsView(task: task)
            }
        }
    }
}

#Preview {
    TasksView()
}
