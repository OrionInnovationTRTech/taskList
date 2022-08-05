//
//  Enums.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 3.08.2022.
//

import Foundation

enum Priority: String {
    case low, medium, high
    
    var value:Int{
        switch self {
        case .low: return 1
        case .medium: return 2
        case .high: return 3
        }
    }
}

enum CustomColor: String, CaseIterable, Identifiable{
    case bubblegum
    case buttercup
    case lavender
    case orange
    case periwinkle
    case poppy
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var id: String{
        rawValue
    }
}
