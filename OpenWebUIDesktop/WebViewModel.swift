import SwiftUI
import Combine

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var progress: Double = 0.0
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var currentURL: URL?
    @Published var isLocalMode: Bool {
        didSet {
            UserDefaults.standard.set(isLocalMode, forKey: "isLocalMode")
            updateURL()
        }
    }
    
    let localURL = URL(string: "http://192.168.3.178:2876/")!
    let externalURL = URL(string: "https://gelting735.synology.me:2876/")!
    
    // Action trigger for WebView
    @Published var shouldReload: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var shouldGoForward: Bool = false
    
    init() {
        self.isLocalMode = UserDefaults.standard.object(forKey: "isLocalMode") as? Bool ?? true
        updateURL()
    }
    
    private func updateURL() {
        currentURL = isLocalMode ? localURL : externalURL
    }
    
    func reload() {
        shouldReload = true
    }
    
    func goBack() {
        shouldGoBack = true
    }
    
    func goForward() {
        shouldGoForward = true
    }
    
    func toggleMode() {
        isLocalMode.toggle()
    }
    
    func goHome() {
        updateURL()
        reload()
    }
}
