//
//  ContentView.swift
//  FirebaseTodo
//
//  Created by Paul Franco on 3/24/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ContentView: View {
    
    private var db: Firestore
    @State private var title: String = ""
    @State private var tasks: [Task] = []
    
    init() {
        db = Firestore.firestore()
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Task", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    let task = Task(title: title)
                    saveData(task: task)
                }, label: {
                    Text("Submit")
                })
                
                List {
                    ForEach(tasks, id: \.id) { task in
                        NavigationLink(
                            destination: TaskDetailView(task: task)) {
                            Text(task.title)
                        }
                    }.onDelete(perform: deleteTask)
                }.listStyle(PlainListStyle())
                
                Spacer()
                    .onAppear(perform: {
                        retrieveData()
                    })
            }.padding()
            .navigationTitle("Tasks")
        }
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let task = tasks[index]
            db.collection("tasks")
                .document(task.id!)
                .delete { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        retrieveData()
                    }
                }
            
        }
    }
    
    private func saveData(task: Task) {
        do {
           _ = try db.collection("tasks").addDocument(from: task) { err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    print("document has been saved")
                    retrieveData()
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func retrieveData() {
        db.collection("tasks")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapshot = snapshot {
                        tasks = snapshot.documents.compactMap { doc in
                            var task = try? doc.data(as: Task.self)
                            if task != nil {
                                task!.id = doc.documentID
                            }
                            return task
                        }
                    }
                }
            }
    }}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
