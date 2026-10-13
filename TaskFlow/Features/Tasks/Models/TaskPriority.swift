//
//  TaskPriority.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import Foundation
import SwiftUI

enum TaskPriority: String, Codable, CaseIterable {
    case low
    case medium
    case high
    
    var color: Color {
        switch self{
        case .low:  return .brown
         case .medium: return Color(red: 1.0, green: 0.75, blue: 0.0)
        case .high: return .red
        }
    }
}
