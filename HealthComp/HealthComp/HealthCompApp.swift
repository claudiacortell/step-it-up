import SwiftUI
import FirebaseCore
import Firebase

@main
struct HealthCompApp: App {
    init() {
        FirebaseApp.configure()
    }
    @StateObject var healthModel = HealthVM()
    @StateObject var userModel = UserVM(healthModel: self.healthModel)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userModel)
//                .environmentObject(healthModel)
        }
    }
}
