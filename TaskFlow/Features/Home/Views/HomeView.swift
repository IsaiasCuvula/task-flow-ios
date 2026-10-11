//
//  ContentView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 8.10.26.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    @Query private var allTasks: [Task] = []
    
    var body: some View {
        NavigationStack{
            VStack {
                ForEach(allTasks){ task in
                        
                    HStack{
                        
                        Button{
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        } label: {
                            Image(systemName:task.isCompleted ? "checkmark.square.fill" :  "square")
                        }
                       
                       
                        Text(task.title)
                            .font(.title3.weight(.light))
                            .padding(.vertical, 2)
                            .foregroundStyle(task.isCompleted ? Color.primary : Color.accentColor )
                        
                        Spacer()
                        
                        
                    }
                    
                }
            }
            .navigationTitle("home")
            .padding()
        }
    }
}

//#Preview {
//    HomeView()
//}
