//
//  TextFieldModel.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 21.07.2022.
//

import Foundation
import CoreData

class TaskModel: ObservableObject{
    @Published var title:String = ""
    @Published var detail:String = ""
    @Published var priority: Priority = .low
    @Published var backgroundColor: CustomColor = .orange
    
    func isTitleValid() -> Bool {
        title != ""
    }
    
    func clear(){
        title = ""
        detail = ""
    }
    
    func addTask(context: NSManagedObjectContext){
        let task = Tasks(context: context)
        task.id = UUID()
        task.title = title
        task.detail = detail
        task.creationDate = Date.now
        task.backgroundColor = backgroundColor.rawValue
        task.priority = priority.rawValue
        task.priorityNumber = Int16(priority.value)
        try? context.save()
    }
    
    func deleteTask(task:Tasks, context: NSManagedObjectContext){
        context.delete(task)
    }
    
    
}
