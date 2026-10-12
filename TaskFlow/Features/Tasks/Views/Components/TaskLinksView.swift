//
//  TasksLinksView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import SwiftUI
import SwiftData

struct TaskLinksView: View {
    let task: Task
    
    var body: some View {
     
        if task.links.isEmpty {
            ContentUnavailableView("empty_links", systemImage: "link")
        }else{
            VStack(spacing: 12) {
                ForEach(task.links){ link in
                        Button{
                            //MARK: - Open link
                        } label: {
                            HStack(spacing: 8){
                                Image(systemName: "link")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                
                                Text(link.link)
                                    .font(.title3)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.right")
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                       
                        
                   
                }
            }
        }
    }
}

//#Preview {
//    TaskLinksView()
//}
