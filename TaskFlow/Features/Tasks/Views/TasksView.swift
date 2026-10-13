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
            ScrollView{
                if allTasks.isEmpty {
                    ContentUnavailableView("empty_tasks", systemImage: "app")
                }
                
                VStack {
                    ForEach(allTasks){ task in
                       TaskTileView(task: task, onTap:{selectedTask = task})
                    }
                }
                .padding()
            }.navigationTitle("tasks")
                .sheet(item: $selectedTask) { task in
                    TaskDetailsView(task: task)
                }
            }
   }
            
}

#Preview {
    
    let container = try! ModelContainer(
        for: Task.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    container.mainContext.insert(Task(title: "Comprar leite", dueDate: .now))
    container.mainContext.insert(Task(title: "Estudar SwiftUI", dueDate: .now))
    container.mainContext.insert(Task(title: "Melhorar SwiftUI", dueDate: .now))

    return TasksView()
        .modelContainer(container)
   
}
