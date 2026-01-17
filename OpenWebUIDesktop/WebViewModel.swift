import SwiftUI
import Combine

@MainActor
class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var progress: Double = 0.0
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var currentURL: URL?
    @Published var zoomLevel: Double {
        didSet {
            UserDefaults.standard.set(zoomLevel, forKey: "zoomLevel")
        }
    }
    @Published var defaultToLocal: Bool {
        didSet {
            UserDefaults.standard.set(defaultToLocal, forKey: "defaultToLocal")
        }
    }
    @Published var isLocalMode: Bool {
        didSet {
            UserDefaults.standard.set(isLocalMode, forKey: "isLocalMode")
            updateURL()
        }
    }
    
    @Published var localURLString: String {
        didSet {
            UserDefaults.standard.set(localURLString, forKey: "localURLString")
            if isLocalMode { updateURL() }
        }
    }
    
    @Published var externalURLString: String {
        didSet {
            UserDefaults.standard.set(externalURLString, forKey: "externalURLString")
            if !isLocalMode { updateURL() }
        }
    }
    
    // Action trigger for WebView
    @Published var shouldReload: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var shouldGoForward: Bool = false
    @Published var shouldGoHome: Bool = false
    
    init() {
        let launchMode = UserDefaults.standard.object(forKey: "defaultToLocal") as? Bool ?? true
        self.defaultToLocal = launchMode
        self.isLocalMode = launchMode
        self.localURLString = UserDefaults.standard.string(forKey: "localURLString") ?? "http://192.168.x.x:2876/"
        self.externalURLString = UserDefaults.standard.string(forKey: "externalURLString") ?? "https://your-domain.me:2876/"
        let zoom = UserDefaults.standard.double(forKey: "zoomLevel")
        self.zoomLevel = zoom == 0 ? 1.0 : zoom
        updateURL()
    }
    
    private func updateURL() {
        let string = isLocalMode ? localURLString : externalURLString
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: trimmed) else { return }

        // Avoid publishing changes while SwiftUI is in the middle of a view update.
        // (This can happen when the value change originates from a Binding update.)
        DispatchQueue.main.async { [weak self] in
            self?.currentURL = url
        }
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
        shouldGoHome = true
    }
    
    func zoomIn() {
        zoomLevel += 0.1
    }
    
    func zoomOut() {
        if zoomLevel > 0.3 {
            zoomLevel -= 0.1
        }
    }
    
    func resetZoom() {
        zoomLevel = 1.0
    }
}
