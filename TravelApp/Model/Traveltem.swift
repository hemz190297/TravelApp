import Foundation

// A model struct representing a travel destination or item
struct TravelItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageURL: String
    let rating: Double? // Optional, default to 4 or 5
}
