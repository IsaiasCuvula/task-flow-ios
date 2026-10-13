//
//  CommonCard.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 13.10.26.
//

import SwiftUI


struct CommonCard<Content: View>: View {
    let color: Color
    let height: CGFloat?
    let content: Content
    var onTap: (() -> Void)?

    init(color: Color = .blue,
         height: CGFloat? = nil,
         onTap: (() -> Void)? = nil,
         @ViewBuilder content: () -> Content) {
        self.color = color
        self.height = height
        self.onTap = onTap
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: height)
        .background(color, in: RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            onTap?()
        }
    }
}

