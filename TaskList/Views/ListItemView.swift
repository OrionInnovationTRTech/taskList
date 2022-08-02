//
//  ListItemView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 21.07.2022.
//

import SwiftUI

struct ListItemView: View {
    @ObservedObject var task:Tasks
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(task.title ?? "")
                    .font(.headline)
                Spacer()
                HStack(){
                    Text(task.creationDate ?? Date.now.addingTimeInterval(86400) ,style: .date)
                    if let firstParagraph = task.detail?.components(separatedBy: CharacterSet.newlines).first {
                        Text(firstParagraph.prefix(10))
                        + Text("...")
                    }
                }
                .font(.caption)
            }
            Spacer()
            Circle()
                .fill(.white)
                .overlay{
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color(task.priority ?? "default"))
                }
                .frame(width:50)
        }
        .padding()
    }
}

//struct ListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItemView()
//            .previewLayout(.fixed(width: 400, height: 60))
//
//    }
//}
