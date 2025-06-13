import SwiftUI
import CachedAsyncImage

struct ListViewScreen: View {
    let item: TravelItem
    let allItems: [TravelItem]
    var animation: Namespace.ID
    var onSelect: (TravelItem) -> Void

    @State private var animateDetails = false

    private let baseImageHeight: CGFloat = 300

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                let yOffset = geometry.frame(in: .global).minY
                let height = yOffset > 0 ? baseImageHeight + yOffset : baseImageHeight

                CachedAsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: height)
                        .clipped()
                        .offset(y: yOffset > 0 ? -yOffset : 0)
                        .matchedGeometryEffect(id: "image-\(item.id)", in: animation)
                } placeholder: {
                    Color.gray
                        .frame(width: UIScreen.main.bounds.width, height: height)
                        .opacity(0.3)
                }
            }
            .frame(height: baseImageHeight)

            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text(item.title)
                    .font(.title)
                    .bold()
                    .matchedGeometryEffect(id: "\(item.id)-title", in: animation)
                    .opacity(animateDetails ? 1 : 0)
                    .animation(.easeOut.delay(0.2), value: animateDetails)

                // Description
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .opacity(animateDetails ? 1 : 0)
                    .animation(.easeOut.delay(0.3), value: animateDetails)

                // Section header
                Text("Explore More Destinations")
                    .font(.headline)
                    .padding(.top)

                // Related items horizontal scroll
                // Related items horizontal scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: 16) { // Use HStack instead of VStack
                        ForEach(allItems.filter { $0.id != item.id }) { otherItem in
                            HStack(spacing: 10) {
                                CachedAsyncImage(url: URL(string: otherItem.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(10)
                                } placeholder: {
                                    Color.gray
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .opacity(0.3)
                                }

                                VStack(alignment: .leading, spacing: 4) {
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
                                .frame(maxWidth: 220, alignment: .leading)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .onTapGesture {
                                onSelect(otherItem)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer(minLength: 40)
            }
         
            .padding()
            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(.systemBackground))
                                    .shadow(radius: 10, y: 4)
                                    .offset(y: -25)
                            )
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemBackground))
        .onAppear {
            animateDetails = true
        }
    }
}
