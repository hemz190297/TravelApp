import SwiftUI

// View for creating a new travel list item
struct CreateListView: View {
    // State variables to hold user input for the new travel item
    @State private var title: String = ""
    @State private var showAlert = false // Controls the display of the alert

    var body: some View {
        NavigationStack {
            Form {
                // Section for entering destination information
                Section(header: Text("Destination Info")) {
                    TextField("Title", text: $title) // Input for the title
                }

                // Button to create the new list item
                Button(action: {
                    // Check if any field is empty, show alert if so
                    if title.isEmpty {
                        showAlert = true
                    } else {
                        // Simulate creating the item (replace with actual logic as needed)
                        print("Created: \(title)")
                        // Reset the fields after creation
                        title = ""
                    }
                }) {
                    // Center the button text
                    HStack {
                        Spacer()
                        Text("Create")
                            .bold()
                        Spacer()
                    }
                }
                .foregroundColor(.white) // Button text color
                .listRowBackground(Color.blue) // Button background color
            }
            .navigationTitle("Create List") // Title in the navigation bar
            .alert(isPresented: $showAlert) {
                // Alert shown when required fields are missing
                Alert(title: Text("Missing Info"),
                      message: Text("Please fill in all fields."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}
