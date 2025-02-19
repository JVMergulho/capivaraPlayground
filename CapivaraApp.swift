import SwiftUI

@available(iOS 17.0, *)
@main
struct capivaraApp: App {
    @StateObject private var audioManager = AudioManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
