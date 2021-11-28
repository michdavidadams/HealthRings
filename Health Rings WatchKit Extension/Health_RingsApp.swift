//
//  Health_RingsApp.swift
//  Health Rings WatchKit Extension
//
//  Created by Michael Adams on 11/28/21.
//

import SwiftUI

@main
struct Health_RingsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
