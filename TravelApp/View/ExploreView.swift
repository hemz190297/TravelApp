import SwiftUI
import CachedAsyncImage

struct ExploreView: View {
    @StateObject private var viewModel = TravelViewModel()  // ViewModel providing travel items
    @Namespace private var animation                         // Namespace for matched geometry animations
    @State private var selectedItem: TravelItem?             // Currently selected item for detail view
    @State private var showDetail = false                     // Controls visibility of detail modal

    let columns = [GridItem(.flexible()), GridItem(.flexible())]  // Two-column grid layout

    var body: some View {
        ZStack {
            // Grid of travel items
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.items) { item in
                        VStack {
                            // Asynchronously load and display image with matched geometry effect
                            CachedAsyncImage(url: URL(string: item.imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width / 2 - 24, height: 180)
                                    .clipped()
                                    .cornerRadius(12)
                                    .matchedGeometryEffect(id: "image-\(item.id)", in: animation)
                            } placeholder: {
                                Color.gray
                                    .frame(height: 180)
                                    .cornerRadius(12)
                                    .opacity(0.3)
                            }

                            // Item title with matched geometry effect for smooth transition
                            Text(item.title)
                                .font(.headline)
                                .padding(.top, 4)
                                .matchedGeometryEffect(id: "\(item.id)-title", in: animation)
                        }
                        .onTapGesture {
                            // Animate and show detail view on tap
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                                selectedItem = item
                                showDetail = true
                            }
                        }
                        // Fade out grid items when detail view is shown
                        .opacity(showDetail ? 0 : 1)
                        .animation(.easeOut, value: showDetail)
                    }
                }
                .padding()
            }

            // Detail modal view shown when an item is selected
            if let selectedItem = selectedItem, showDetail {
                ListViewScreen(
                    item: selectedItem,
                    allItems: viewModel.items,
                    animation: animation
                ) { newSelection in
                    // Update detail view with newly selected item from modal's related list
                    withAnimation(.spring(response: 1, dampingFraction: 0.8)) {
                        self.selectedItem = newSelection
                    }
                }
                .background(Color.white)
                .zIndex(1)  // Ensure detail modal is above grid
                .transition(.asymmetric(
                    insertion: .opacity.animation(.easeIn),
                    removal: .opacity.animation(.easeOut.delay(0.1))
                ))
                .onTapGesture {
                    // Hide detail modal on tap outside content
                    withAnimation(.spring(response: 1, dampingFraction: 0.8)) {
                        showDetail = false
                    }
                    // Clear selection after animation completes
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.selectedItem = nil
                    }
                }
            }
        }
        .onDisappear {
            // Reset state when view disappears (e.g., navigating away)
            selectedItem = nil
            showDetail = false
        }
    }
}
