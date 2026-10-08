//
//  MainTabView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 9.10.26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            Tab("Home", systemImage: "tray"){
                HomeView()
            }
            
            Tab("Tasks", systemImage: "checkmark.app"){
                TasksView()
            }
            
            Tab("Calendar", systemImage: "calendar"){
                CalendarView()
            }
            
        }
    }
}

#Preview {
    MainTabView()
}
