//
//  CalendarView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 9.10.26.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @State private var selectedDate = Date.now
    @Query private var allTasks: [Task] = []
    @State private var selectedTask: Task? = nil
    @State private var viewModel = CalendarViewModel()
    
    private var filteredTasks: [Task]  {
        return viewModel.tasksByDate(tasks: allTasks, date: selectedDate)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    WeekCalendarView(selectedDate: $selectedDate)
                        .padding(.bottom)
                    
                    
                    if filteredTasks.isEmpty {
                        
                        ContentUnavailableView("empty_tasks", systemImage: "checklist.checked")
                            .scaleEffect(0.8)
                            .padding(.vertical)
                        
                    }
                    
                    ForEach(filteredTasks){ task in
                       TaskTileView(task: task, onTap:{selectedTask = task})
                    }
                    
                }
                .padding()
            }
            .navigationTitle("calendar")
            .sheet(item: $selectedTask) { task in
                TaskDetailsView(task: task)
            }
        }
    }
}

#Preview {
    CalendarView()
}
