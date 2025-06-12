import SwiftUI
import HomeKit
import CachedAsyncImage

// Main view for exploring travel destinations
struct ExploreView: View {
    @StateObject private var viewModel = TravelViewModel() // ViewModel holding travel items
    @Namespace private var animation // Namespace for matched geometry animations
    @State private var selectedItem: TravelItem? // Currently selected item for detail view
    @State private var showDetail = false // Controls whether detail view is shown
    @GestureState private var dragOffset: CGFloat = 100
    // Two-column flexible grid layout
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            // Scrollable grid of travel items
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.items) { item in
                        VStack {
                            // Asynchronously loads and displays the item's image
                            CachedAsyncImage(url: URL(string: item.imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 24, height: 180)
                                    .clipped()
                                    .cornerRadius(12)
                                    .matchedGeometryEffect(id: item.id, in: animation) // Enables smooth transition
                                    
                            } placeholder: {
                                // Placeholder while image loads
                                Color.gray
                                    .frame(height: 180)
                                    .cornerRadius(12)
                                    .opacity(0.3)
                            }
//                            .scaleEffect(selectedItem == item ? 1.1 : 1.0) // Enlarge image if selected
//                            .animation(.spring(), value: selectedItem) // Animate scale change

                            // Item title with matched geometry for smooth animation
                            Text(item.title)
                                .font(.headline)
                                .padding(.top, 4)
                                .matchedGeometryEffect(id: "\(item.id)-title", in: animation)
                        }
                        .onTapGesture {
                            // Animate to detail view when item is tapped
                            withAnimation(.spring(response: 1, dampingFraction: 0.8)) {
                                selectedItem = item
                                showDetail = true
                            }
                        }
//                        .rotation3DEffect( // Example: 3D rotation effect (currently commented out)
//                            .degrees(Double(UIScreen.main.bounds.width) / 20.0),
//                            axis: (x: 1, y: 1, z: 0)
//                        )
                        .opacity(showDetail ? 0 : 1) // Fade out grid when detail view is shown
                        .animation(.easeOut, value: showDetail)
                    }
                }
                .padding()
            }

            // Show detail view if an item is selected and showDetail is true
            if let selectedItem = selectedItem, showDetail {
                ListViewScreen(item: selectedItem, animation: animation)
                    .background(Color.white)
                    .zIndex(1) // Ensure detail view is above the grid
                    .transition(.asymmetric( // Custom transition for showing/hiding detail view
                        insertion: .opacity.animation(.easeIn),
                        removal: .opacity.animation(.easeOut.delay(0.1))
                    ))
                    .onTapGesture {
                        // Hide detail view with animation when tapped
                        withAnimation(.spring(response: 1, dampingFraction: 0.8)) {
                            showDetail = false
                        }
                        // Reset selectedItem after animation completes
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.selectedItem = nil
                        }
                    }
            }
        }
        .onDisappear {
            // Reset state when navigating away from ExploreView (e.g., switching tabs)
            selectedItem = nil
            showDetail = false
        }
       /* .navigationTitle("Explore")*/ // Title in the navigation bar
    }
} 
