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
    @State private var viewModel = HomeViewModel()
    @State private var selectedTask: Task? = nil
    
    private var noUrgentTasks: [Task] {
        let lowTasks = viewModel.tasksByPriority(tasks: allTasks, priority: .low)
        let mediumTasks = viewModel.tasksByPriority(tasks: allTasks, priority: .medium)

        return lowTasks + mediumTasks
    }
    
    private var urgentTasks: [Task] {
        return viewModel.tasksByPriority(tasks: allTasks, priority: TaskPriority.high)
    }
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    LazyVStack {
                        highlightCards
                        
                        HStack{
                            Text("urgent_tasks")
                                .font(.title3.weight(.bold))
                                .padding(.bottom, 2)
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        
                        if urgentTasks.isEmpty {
                            Text("empty_tasks")
                                .font(.title3.weight(.medium))
                                .padding(.bottom, 2)
                        }
                        
                        
                        ForEach(urgentTasks){ task in
                            TaskTileView(task: task, onTap: {
                                selectedTask = task
                            })
                        }
                }.padding(.horizontal)
            }
            .navigationTitle("home")
            .searchable(text: $searchText, prompt: "search_task")
            .sheet(item: $selectedTask) { task in
                TaskDetailsView(task: task)
            }
        }
    }
    
    @ViewBuilder
    private var highlightCards: some View {
        
        switch noUrgentTasks.count {
        case 0:
            ContentUnavailableView("empty_tasks", systemImage: "list.bullet.indent")
            
        case 1:
            let a = noUrgentTasks[0]
            HomeTaskCardView(task: a, color: .blue, height: 120) {
                selectedTask = a
            }
        case 2:
            let a = noUrgentTasks[0]
            let b = noUrgentTasks[1]
            HStack(spacing: 12) {
                HomeTaskCardView(task: a, color: .blue) { selectedTask = a }
                HomeTaskCardView(task: b, color: .green) { selectedTask = b }
            }
            
        default:
            let a = noUrgentTasks[0]
            let b = noUrgentTasks[1]
            let c = noUrgentTasks[2]
            HStack(spacing: 12) {
                HomeTaskCardView(task: a, color: Color.accent, height: 212){
                    selectedTask = a
                }
                VStack(spacing: 12) {
                    HomeTaskCardView(task: b, color: .blue) {
                        selectedTask = b
                    }
                    HomeTaskCardView(task: c, color: .green) {
                        selectedTask = c
                    }
                }
            }
            .frame(height: 212)
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

    return HomeView()
        .modelContainer(container)
}
