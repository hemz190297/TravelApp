import SwiftUI

// Profile screen view
struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) { // Vertical stack with spacing between elements
            
                // User profile image (system icon)
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120) // Set image size
                    .foregroundColor(.blue) // Set image color
                    .padding(.top, 40) // Add space at the top

                // User name
                Text("Hemant Sonkusare")
                    .font(.title2)
                    .fontWeight(.bold)

                // User role or description
                Text("iOS Developer")
                    .foregroundColor(.secondary) // Subtle text color

                // Divider to separate profile info from the list
                Divider()
                    .padding(.vertical, 20) // Add vertical padding

                // List of profile-related actions
                List {
                    Label("Edit Profile", systemImage: "pencil") // Edit profile option
                    Label("Notifications", systemImage: "bell") // Notifications option
                    Label("Settings", systemImage: "gear") // Settings option
                    Label("Logout", systemImage: "arrow.right.square") // Logout option
                }
            }
            .navigationTitle("Profile") // Title in the navigation bar
        }
    }
}
