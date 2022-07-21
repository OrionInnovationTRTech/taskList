//
//  TextFieldModel.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 21.07.2022.
//

import Foundation

class TaskModel: ObservableObject{
    @Published var title:String = ""
    @Published var detail:String = ""
    
    func isTitleValid() -> Bool {
        title != ""
    }
    
    func clear(){
        title = ""
        detail = ""
    }
}
