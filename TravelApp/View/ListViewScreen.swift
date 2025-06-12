import SwiftUI
import CachedAsyncImage

struct ListViewScreen: View {
    let item: TravelItem                  // The currently selected travel item to display details for
    let allItems: [TravelItem]            // List of all travel items, used to show related items in the modal
    var animation: Namespace.ID           // Namespace for matched geometry animation
    var onSelect: (TravelItem) -> Void    // Closure to handle selection of another item from the related list
    
    @State private var animateDetails = false     // State to control fade-in animation of details
    @GestureState private var dragOffset: CGFloat = 0  // Gesture state to track vertical drag offset for stretchy image effect
    
    private let baseImageHeight: CGFloat = 300    // Base height of the main image
    private let minImageHeight: CGFloat = 120     // Minimum height for the image when dragging down
    
    var body: some View {
        GeometryReader { proxy in
            // Calculate the dynamic image height based on drag offset (stretchy effect)
            let imageHeight = max(minImageHeight, baseImageHeight + dragOffset)
            
            ZStack(alignment: .top) {
                // Main image with matched geometry effect and spring animation
                CachedAsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: imageHeight)
                        .clipped()
                        .matchedGeometryEffect(id: item.id, in: animation)
                        .animation(.spring(response: 0.45, dampingFraction: 0.75), value: dragOffset)
                } placeholder: {
                    // Placeholder gray color while image loads
                    Color.gray
                        .frame(width: proxy.size.width, height: imageHeight)
                        .opacity(0.3)
                }
                
                // Modal card containing details and horizontal scrollable list
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title text with matched geometry effect and fade-in animation
                        Text(item.title)
                            .font(.title)
                            .bold()
                            .matchedGeometryEffect(id: "\(item.id)-title", in: animation)
                            .opacity(animateDetails ? 1 : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8).delay(0.2), value: animateDetails)
                        
                        // Description text with fade-in animation
                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .opacity(animateDetails ? 1 : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8).delay(0.4), value: animateDetails)
                        
                        // Section header for related destinations
                        Text("Explore More Destinations")
                            .font(.headline)
                            .padding(.top)
                        
                        // Horizontally scrollable list of other travel items as cards
                        ScrollView(.horizontal, showsIndicators: false) {
                            VStack(spacing: 16) {
                                ForEach(allItems.filter { $0.id != item.id }) { otherItem in
                                    HStack(alignment: .top, spacing: 12) {
                                        // Image on the left side of the card
                                        CachedAsyncImage(url: URL(string: otherItem.imageURL)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .clipped()
                                                .cornerRadius(10)
                                        } placeholder: {
                                            // Placeholder while image loads
                                            Color.gray
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(10)
                                                .opacity(0.3)
                                        }
                                        
                                        // VStack containing title, description, and rating aligned vertically
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(otherItem.title)
                                                .font(.headline)
                                                .lineLimit(1)
                                            
                                            Text(otherItem.description)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                                .lineLimit(2)
                                            
                                            if let rating = otherItem.rating {
                                                HStack(spacing: 4) {
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(.yellow)
                                                        .font(.caption)
                                                    Text(String(format: "%.1f", rating))
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                        }
                                        .frame(maxWidth: 240, alignment: .leading)
                                    }
                                    .padding(12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.systemGray6))
                                    )
                                    .shadow(radius: 2)
                                    // Handle tap on a related item to update the detail view
                                    .onTapGesture {
                                        onSelect(otherItem)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 4)
                        }
                        
                        Spacer() // Push content up if needed
                    }
                }
                .padding()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 10, y: 4)
                )
                // Offset the modal card to overlap the image by 20 points
                .offset(y: imageHeight - 20)
                .animation(.spring(response: 0.45, dampingFraction: 1), value: dragOffset)
            }
            // Drag gesture to enable stretchy image effect by dragging down
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        if value.translation.height > 0 {
                            state = value.translation.height
                        }
                    }
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear { animateDetails = true } // Trigger fade-in animation on appear
        }
    }
}
