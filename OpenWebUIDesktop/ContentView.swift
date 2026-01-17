//
//  ContentView.swift
//  OpenWebUIDesktop
//
//  Created by Roman on 17.01.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress Bar
            if viewModel.isLoading {
                ProgressView(value: viewModel.progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 2)
                    .transition(.opacity)
            } else {
                Divider()
                    .frame(height: 2)
            }
            
            // WebView
            WebView(viewModel: viewModel)
                .frame(minWidth: 800, minHeight: 600)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button(action: viewModel.goBack) {
                    Image(systemName: "chevron.left")
                }
                .disabled(!viewModel.canGoBack)
                
                Button(action: viewModel.goForward) {
                    Image(systemName: "chevron.right")
                }
                .disabled(!viewModel.canGoForward)
                
                Button(action: viewModel.reload) {
                    Image(systemName: "arrow.clockwise")
                }
                
                Button(action: viewModel.goHome) { 
                    Image(systemName: "house")
                }
                .help("Go to Home")
            }
            
            ToolbarItem(placement: .status) {
                Picker("Mode", selection: $viewModel.isLocalMode) {
                    Label("Local", systemImage: "house").tag(true)
                    Label("External", systemImage: "globe").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
            }
        }
        .navigationTitle(viewModel.isLocalMode ? "OpenWebUI (Local)" : "OpenWebUI (External)")
    }
}

#Preview {
    ContentView()
}
