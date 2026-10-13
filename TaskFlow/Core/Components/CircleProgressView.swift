//
//  CircleProgressView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 13.10.26.
//

import SwiftUI

struct CircleProgressView: View {
    let progress: Double
        var color: Color = .green
        var lineWidth: CGFloat = 4
        var size: CGFloat = 44

        var body: some View {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.25), lineWidth: lineWidth)

                Circle()
                    .trim(from: 0, to: min(max(progress, 0), 1))
                    .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: progress)

                Text("\(Int((progress * 100).rounded()))%")
                    .font(.system(size: size * 0.25, weight: .bold))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            .frame(width: size, height: size)
        }
    }

#Preview {
   let task = Task.samples.last!
    
   return CircleProgressView(
        progress: task.progress,
        color: task.priority.color,
    )
}
