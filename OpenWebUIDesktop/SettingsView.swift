import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: WebViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var localURL: String = ""
    @State private var externalURL: String = ""
    @State private var defaultToLocal: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section(header: Text("Server Addresses")) {
                    TextField("Local URL", text: $localURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("External URL", text: $externalURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Startup Preference")) {
                    Picker("Start with", selection: $defaultToLocal) {
                        Text("External URL").tag(false)
                        Text("Local URL").tag(true)
                    }
                    .pickerStyle(RadioGroupPickerStyle())
                }
            }
            
            HStack(spacing: 16) {
                Button("Cancel") {
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)
                .controlSize(.large)
                
                Button("Done") {
                    viewModel.localURLString = localURL
                    viewModel.externalURLString = externalURL
                    viewModel.defaultToLocal = defaultToLocal
                    viewModel.goHome()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .keyboardShortcut(.defaultAction)
                .controlSize(.large)
            }
            .padding(.top, 40)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            localURL = viewModel.localURLString
            externalURL = viewModel.externalURLString
            defaultToLocal = viewModel.defaultToLocal
        }
        .frame(width: 400, height: 300)
    }
}
