import SwiftUI
import FirebaseCore
import Firebase

@main
struct HealthCompApp: App {
    init() {
        FirebaseApp.configure()
    }
    @StateObject var userModel = UserVM()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userModel)
        }
    }
}
