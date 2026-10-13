//
//  MainTabView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 9.10.26.
//

import SwiftUI

struct MainTabView: View {
    @State private var showAddTask: Bool = false
    @State private var tabSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabSelection){
            Tab("home", systemImage: "tray", value: 0){
                HomeView()
            }
            
            Tab("tasks", systemImage: "checkmark.app", value: 1){
                TasksView()
            }
            
            Tab("calendar", systemImage: "calendar", value: 2){
                CalendarView()
            }
            
            Tab("add", systemImage: "plus", value: 3, role: .search) {
                Color.clear
            }
        }
        .fontDesign(.rounded)
        .onChange(of: tabSelection) { old, new in
            if new == 3 {
                tabSelection = old
                showAddTask = true
            }
            
        }
        .sheet(isPresented: $showAddTask) {
            AddTaskView()
        }
        
    }
}

#Preview {
    MainTabView()
}
