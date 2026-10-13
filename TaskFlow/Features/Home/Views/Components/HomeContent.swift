//
//  HomeContent.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 14.10.26.
//

import SwiftUI

struct HomeContent: View {
    @Environment(\.isSearching) private var isSearching
    let searchText: String
    let allTasks: [Task]
    @Binding var selectedTask: Task?
    @State private var viewModel = HomeViewModel()
    
    private var noUrgentTasks: [Task] {
        let lowTasks = viewModel.tasksByPriority(tasks: allTasks, priority: .low)
        let mediumTasks = viewModel.tasksByPriority(tasks: allTasks, priority: .medium)

        return lowTasks + mediumTasks
    }
    
    private var urgentTasks: [Task] {
        return viewModel.tasksByPriority(tasks: allTasks, priority: TaskPriority.high)
    }

       var body: some View {

           Group {
               if isSearching {
               SearchResultsView(
                   tasks: allTasks,
                   searchText: searchText,
                   selectedTask: $selectedTask
               )
           } else {
               ScrollView{
                   LazyVStack {
                       highlightCards
                       HStack{
                           Text("urgent_tasks")
                               .font(.title3.weight(.bold))
                               .padding(.bottom, 2)
                           
                           Spacer()
                       }.padding(.top)
                       if urgentTasks.isEmpty{
                           Text("no_urgent_tasks")
                               .font(.footnote.weight(.medium))
                               .padding()
                       }
                       ForEach(urgentTasks){ task in
                           TaskTileView(task: task, onTap: {
                               selectedTask = task
                           })
                       }
                   }.padding(.horizontal)
               }
           }
       }
    }
    
    @ViewBuilder
    private var highlightCards: some View {
        
        switch noUrgentTasks.count {
        case 0:
            if urgentTasks.isEmpty{
                ContentUnavailableView("empty_tasks", systemImage: "checklist.checked")
                    .scaleEffect(0.8)
            }
           
            
        case 1:
            let a = noUrgentTasks[0]
            HomeTaskCardView(task: a, color: Color.accent, height: 120) {
                selectedTask = a
            }
        case 2:
            let a = noUrgentTasks[0]
            let b = noUrgentTasks[1]
            HStack(spacing: 12) {
                HomeTaskCardView(task: a, color: Color.accent) { selectedTask = a }
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


