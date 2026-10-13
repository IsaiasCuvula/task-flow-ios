//
//  HomeTaskCardView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 13.10.26.
//

import SwiftUI

struct HomeTaskCardView: View {
    let task: Task
    var color: Color = .green
    var height: CGFloat = 100
    var onTap: (() -> Void)? = nil
    
    private var isCompact: Bool { height < 150}
    
    var body: some View {
        CommonCard(
            color: color,
            height: height,
            onTap: onTap,
        ){
            Text(task.title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
            
            
            VStack{
                ProgressView(value: task.progress)
                    .tint(task.priority.color)
                
                HStack{
                    Text("progress")
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text(task.progress.formatted(.percent.precision(.fractionLength(0))))
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(.white)
                }
            }.padding(.top, isCompact ? 0: 16)
            
            Spacer()
            if let date = task.dueDate {
                Text("due: \(date.formatted(date: .abbreviated, time: .omitted))")
                    .font(.footnote)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    HomeTaskCardView(
        task: Task.samples.first!,
        color: Color.accent,
    )
}
