//
//  ContentView.swift
//  OpenWebUIDesktop
//
//  Created by Roman on 17.01.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebViewModel()
    @State private var isShowingSettings = false
    
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
            ToolbarItemGroup(placement: .principal) {
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
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
                    
                    Divider().frame(height: 16)
                    
                    Picker("Mode", selection: $viewModel.isLocalMode) {
                        Label("External", systemImage: "globe").tag(false)
                        Label("Local", systemImage: "house").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                    
                    Divider().frame(height: 16)
                    
                    HStack(spacing: 2) {
                        Button(action: viewModel.zoomOut) {
                            Image(systemName: "minus.magnifyingglass")
                        }
                        .help("Zoom Out")
                        
                        Button(action: viewModel.resetZoom) {
                            Text("\(Int(viewModel.zoomLevel * 100))%")
                                .font(.caption2)
                                .frame(width: 38)
                        }
                        .help("Reset Zoom")
                        
                        Button(action: viewModel.zoomIn) {
                            Image(systemName: "plus.magnifyingglass")
                        }
                        .help("Zoom In")
                    }
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button(action: { isShowingSettings.toggle() }) {
                    Image(systemName: "gear")
                }
            }
        }
        .navigationTitle(viewModel.isLocalMode ? "OpenWebUI (Local)" : "OpenWebUI (External)")
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
