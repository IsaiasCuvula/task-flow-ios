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
    @Query(sort: \Task.dueDate) private var alltAsks: [Task] = []
    @State private var showEditTask = false
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(alltAsks){ task in
                    
                        HStack(spacing: 8){
                            Button{
                                task.isCompleted.toggle()
                            } label: {
                                Image(systemName:task.isCompleted ? "checkmark.app.fill" : "app")
                                    .foregroundStyle(task.isCompleted  ?  AnyShapeStyle(.tint) : AnyShapeStyle(.secondary))
                            }
                            .buttonStyle(.plain)
                           
                            Button{
                                showEditTask.toggle()
                            } label: {
                                VStack(alignment: .leading,spacing: 4){
                                    Text(task.title)
                                        .font(.title3)
                                        .lineLimit(1)
                                    
                                    HStack(spacing: 4){
                                        if let note = task.note{
                                            Text(note)
                                                .font(.footnote)
                                                .lineLimit(1)
                                        }
                                        if let date = task.dueDate{
                                            Text(
                                                date.formatted(date:.abbreviated, time:.omitted))
                                            .foregroundStyle(.secondary)
                                            .font(.footnote.weight(.regular))
                                        }
                                    }
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
            .sheet(isPresented: $showEditTask) {
                    //
            }
        }
    }
}

#Preview {
    TasksView()
}
