//
//  OpenWebUIDesktopApp.swift
//  OpenWebUIDesktop
//
//  Created by Roman on 17.01.2026.
//

import SwiftUI

@main
struct OpenWebUIDesktopApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.automatic)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
