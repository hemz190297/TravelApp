import SwiftUI
import CachedAsyncImage

struct ListViewScreen: View {
    let item: TravelItem
    var animation: Namespace.ID
    @State private var animateDetails = false
    @GestureState private var dragOffset: CGFloat = 0

    private let baseImageHeight: CGFloat = 300
    private let minImageHeight: CGFloat = 120

    var body: some View {
        GeometryReader { proxy in
            let imageHeight = max(minImageHeight, baseImageHeight + dragOffset)

            ZStack(alignment: .top) {
                // Stretchy Image
                CachedAsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: imageHeight)
                        .clipped()
                        .matchedGeometryEffect(id: item.id, in: animation)
                        .animation(.spring(response: 0.45, dampingFraction: 0.75), value: dragOffset)
                } placeholder: {
                    Color.gray
                        .frame(width: proxy.size.width, height: imageHeight)
                        .opacity(0.3)
                }

                // Modal Card (overlapping image by 10 pixels)
                ScrollView{
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.title)
                            .bold()
                            .matchedGeometryEffect(id: "\(item.id)-title", in: animation)
                            .opacity(animateDetails ? 1 : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8).delay(0.2), value: animateDetails)

                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .opacity(animateDetails ? 1 : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8).delay(0.4), value: animateDetails)

                        HStack {
                            Text("Places")
                                .font(.caption)
                                .background(.gray.opacity(0.3))
                                .cornerRadius(10)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 20)
                            
                            Image(systemName: "eye.circle.fill")
                                .foregroundColor(.gray) // Optional: set icon color
                            Text("10")
                        }
                        Spacer()
                    }
                }
                .padding()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 10, y: 4)
                )
                .offset(y: imageHeight - 20) // <-- Overlap modal on image by 10 pixels
                .animation(.spring(response: 0.45, dampingFraction: 1), value: dragOffset)
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        if value.translation.height > 0 {
                            state = value.translation.height
                        }
                    }
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear { animateDetails = true }
        }
    }
} 

