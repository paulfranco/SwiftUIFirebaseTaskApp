//
//  FirebaseTodoApp.swift
//  FirebaseTodo
//
//  Created by Paul Franco on 3/24/21.
//

import SwiftUI
import Firebase

@main
struct FirebaseTodoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        // This closure returns a view
        WindowGroup {
            ContentView()
        }
    }
}
