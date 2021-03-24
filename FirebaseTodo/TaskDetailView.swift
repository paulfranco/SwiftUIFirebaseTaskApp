//
//  TaskDetailView.swift
//  FirebaseTodo
//
//  Created by Paul Franco on 3/24/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct TaskDetailView: View {
    
    let db: Firestore = Firestore.firestore()
    let task: Task
    @State private var title: String = ""
    
    
    var body: some View {
        
        VStack {
            TextField(task.title, text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                updateTask()
            }
        }.padding()
    }
    
    private func updateTask() {
        db.collection("tasks")
            .document(task.id!)
            .updateData([
                "title": title
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("update successfull")
                }
            }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(id: "333", title: "Choronzon"))
    }
}
