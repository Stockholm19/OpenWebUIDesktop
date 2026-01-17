import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    
    func makeNSView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        
        // Add observer for progress
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        
        if let url = viewModel.currentURL {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if viewModel.shouldReload {
            nsView.reload()
            DispatchQueue.main.async {
                viewModel.shouldReload = false
            }
        }
        
        if viewModel.shouldGoBack {
            nsView.goBack()
            DispatchQueue.main.async {
                viewModel.shouldGoBack = false
            }
        }
        
        if viewModel.shouldGoForward {
            nsView.goForward()
            DispatchQueue.main.async {
                viewModel.shouldGoForward = false
            }
        }
        
        // Handle URL change when mode is toggled
        if let currentURL = nsView.url, let targetURL = viewModel.currentURL, currentURL != targetURL {
            // Only load if the base domain/port changed significantly (not just navigation within the app)
            // But for mode toggle, we definitely want to reload the specific target URL
            if !currentURL.absoluteString.contains(targetURL.host ?? "") {
                 nsView.load(URLRequest(url: targetURL))
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var viewModel: WebViewModel
        
        init(viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            guard let webView = object as? WKWebView else { return }
            
            DispatchQueue.main.async {
                if keyPath == #keyPath(WKWebView.estimatedProgress) {
                    self.viewModel.progress = webView.estimatedProgress
                } else if keyPath == #keyPath(WKWebView.isLoading) {
                    self.viewModel.isLoading = webView.isLoading
                } else if keyPath == #keyPath(WKWebView.canGoBack) {
                    self.viewModel.canGoBack = webView.canGoBack
                } else if keyPath == #keyPath(WKWebView.canGoForward) {
                    self.viewModel.canGoForward = webView.canGoForward
                }
            }
        }
    }
}
