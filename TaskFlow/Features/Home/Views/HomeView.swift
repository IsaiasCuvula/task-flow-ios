//
//  ContentView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 8.10.26.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    @Query(sort: \Task.dueDate) private var allTasks: [Task] = []
    @State private var searchText = ""
    @State private var selectedTask: Task?
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            HomeContent(
                searchText: searchText,
                allTasks: allTasks,
                selectedTask: $selectedTask
            )
            .navigationTitle("home")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "search_task"
            )
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
//    container.mainContext.insert(Task(title: "Estudar SwiftUI", dueDate: .now))
//    container.mainContext.insert(Task(title: "Melhorar SwiftUI", dueDate: .now))

    return HomeView()
        .modelContainer(container)
}
