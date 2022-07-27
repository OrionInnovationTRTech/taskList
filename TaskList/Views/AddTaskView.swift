//
//  addTaskView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 20.07.2022.
//

import SwiftUI

struct addTaskView: View {
    
    @EnvironmentObject var taskModel: TaskModel
    
    var body: some View {
        Form{
            Section(header:Text("Title")){
                TextField("Enter Task", text:$taskModel.title)
            }
            Section(header: Text("Details")){
                TextEditor(text:$taskModel.detail)
            }
        }
    }
}

struct addTaskView_Previews: PreviewProvider {
    static var previews: some View {
        addTaskView()
            .environmentObject(TaskModel())
    }
}
