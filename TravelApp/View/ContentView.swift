import SwiftUI

// The main ContentView containing the TabView for the app's navigation
struct ContentView: View {
    var body: some View {
        TabView {
            
            // First tab: Explore section wrapped in a NavigationStack
            NavigationStack {
                ExploreView() // Shows the Explore screen
            }
            .tabItem {
                Label("Explore", systemImage: "magnifyingglass") // Tab icon and label
            }

            // Second tab: Create List section wrapped in a NavigationStack
            NavigationStack {
                CreateListView() // Shows the Create List screen
            }
            .tabItem {
                Label("Create List", systemImage: "plus") // Tab icon and label
            }

            // Third tab: Profile section wrapped in a NavigationStack
            NavigationStack {
                ProfileView() // Shows the Profile screen
            }
            .tabItem {
                Label("Profile", systemImage: "person") // Tab icon and label
            }
        }
    }
}
