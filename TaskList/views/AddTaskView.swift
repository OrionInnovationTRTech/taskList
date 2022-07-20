//
//  addTaskView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 20.07.2022.
//

import SwiftUI

struct addTaskView: View {
    
    @Binding var title: String
    @Binding var detail: String
    
    var body: some View {
        Form{
            Section(header:Text("Title")){
                TextField("Enter Task", text:$title)
            }
            Section(header: Text("Details")){
                TextEditor(text:$detail)
            }
        }
    }
}

//struct addTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        addTaskView()
//    }
//}
