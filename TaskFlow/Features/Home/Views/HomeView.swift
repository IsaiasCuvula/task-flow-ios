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
        let noUrgentTasks = viewModel.nonUrgentTasks(tasks: allTasks)
        guard !searchText.isEmpty else { return noUrgentTasks}
        return noUrgentTasks.filter { task in
            task.title.localizedStandardContains(searchText) ||
            ((task.note?.localizedStandardContains(searchText)) != nil)
        }
    }
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    VStack {
                        if noUrgentTasks.isEmpty {
                            ContentUnavailableView("empty_tasks", systemImage: "list.bullet.indent")
                        }
                        
                        
                        if noUrgentTasks.count == 1 {
                            HomeTaskCardView(
                                task: allTasks.first!,
                                color: Color.blue,
                                height: 120,
                                onTap: {
                                    selectedTask =  allTasks.first!
                                }
                            )
                        }
                        
                        if noUrgentTasks.count == 2 {
                            HStack(spacing: 12){
                                HomeTaskCardView(
                                    task: allTasks.first!,
                                    color: Color.blue,
                                    onTap: {
                                        selectedTask =  allTasks.first!
                                    }
                                )
                                HomeTaskCardView(
                                    task: allTasks.first!,
                                    color: Color.green,
                                    onTap: {
                                        selectedTask =  allTasks.first!
                                    }
                                )
                            }.frame(maxWidth: .infinity)
                        }
                        
                        
                        
                        if noUrgentTasks.count == 3 {
                            HStack(spacing: 12){
                                HomeTaskCardView(
                                    task: allTasks.first!,
                                    color: Color.accent,
                                    height: 212,
                                    onTap: {
                                        selectedTask =  allTasks.first!
                                    }
                                )
                                
                                VStack(spacing: 12){
                                    HomeTaskCardView(
                                        task: allTasks.first!,
                                        color: Color.blue,
                                    )
                                    HomeTaskCardView(
                                        task: allTasks.first!,
                                        color: Color.green,
                                        onTap: {
                                            selectedTask =  allTasks.first!
                                        }
                                    )
                                }
                            }.frame(height: 212)
                        }
                        
                        
                        
                        HStack{
                            Text("urgent tasks")
                                .font(.title3.weight(.bold))
                                .padding(.bottom, 2)
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        
                        ForEach(noUrgentTasks){ task in
                            TaskTileView(task: task, onTap: {
                                selectedTask = task
                            })
                           
                        }
                }
            }
            .navigationTitle("home")
            .searchable(text: $searchText, prompt: "search_task")
            .padding()
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

    return HomeView()
        .modelContainer(container)
}
