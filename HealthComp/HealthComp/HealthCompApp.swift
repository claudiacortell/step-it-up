//
//  HealthCompApp.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct HealthCompApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserVM())
        }
    }
}
