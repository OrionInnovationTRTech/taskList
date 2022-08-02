//
//  TextFieldModel.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 21.07.2022.
//

import Foundation
import SwiftUI

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

class TaskModel: ObservableObject{
    @Published var title:String = ""
    @Published var detail:String = ""
    @Published var priority: Priority = .low
    
    func isTitleValid() -> Bool {
        title != ""
    }
    
    func clear(){
        title = ""
        detail = ""
    }
}
