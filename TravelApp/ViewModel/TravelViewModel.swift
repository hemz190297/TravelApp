import SwiftUI

// ViewModel managing the list of travel items, conforming to ObservableObject
class TravelViewModel: ObservableObject {
    // Published property to notify views when the items array changes
    @Published var items: [TravelItem] = [
        TravelItem(
            title: "Paris",
            description: "The city of light, romance, and world-famous cuisine. Wander through charming neighborhoods, marvel at the Eiffel Tower, and savor pastries in cozy cafés. Explore iconic art at the Louvre and stroll along the Seine. Paris offers a timeless blend of history and modern elegance.",
            imageURL: "https://picsum.photos/seed/mountain/200/150",
            rating: 4.3
        ),
        TravelItem(
            title: "Tokyo",
            description: "A vibrant metropolis where tradition meets innovation. Discover ancient temples alongside neon-lit skyscrapers. Enjoy sushi at bustling markets, experience cherry blossom season, and shop in trendy districts. Tokyo is a city of endless energy and cultural surprises.",
            imageURL: "https://picsum.photos/seed/beach/200/150",
            rating: 4.5
        ),
        TravelItem(
            title: "New York",
            description: "The city that never sleeps, filled with iconic landmarks and diverse neighborhoods. Visit Central Park, catch a Broadway show, and explore world-class museums. From towering skyscrapers to hidden speakeasies, New York offers excitement at every corner.",
            imageURL: "https://picsum.photos/seed/city/200/150",
            rating: 3.8
        ),
        TravelItem(
            title: "Sydney",
            description: "Home to the stunning Opera House and beautiful harbor views. Relax on golden beaches, climb the Sydney Harbour Bridge, and discover vibrant markets. Sydney blends laid-back coastal living with cosmopolitan culture and adventure.",
            imageURL: "https://picsum.photos/seed/desert/200/150",
            rating: 2.4
        ),
        TravelItem(
            title: "Rome",
            description: "The Eternal City, rich with ancient history and awe-inspiring architecture. Wander through cobblestone streets, marvel at the Colosseum, and enjoy authentic Italian cuisine. Rome’s timeless charm and vibrant piazzas captivate every traveler.",
            imageURL: "https://picsum.photos/seed/forest/200/150",
            rating: 3.1
        ),
        TravelItem(
            title: "London",
            description: "Historic landmarks, royal palaces, and a thriving arts scene await in London. Explore the British Museum, stroll through Hyde Park, and experience diverse cuisine. The city’s blend of tradition and modernity makes it endlessly fascinating.",
            imageURL: "https://picsum.photos/seed/road/200/150",
            rating: 4.8
        ),
        TravelItem(
            title: "Barcelona",
            description: "A city of art, beaches, and delicious food. Admire Gaudí’s colorful architecture, relax on Mediterranean shores, and savor tapas in lively markets. Barcelona’s creative spirit and warm atmosphere make it a must-visit destination.",
            imageURL: "https://picsum.photos/seed/cliff/200/150",
            rating: 5.0
        ),
        TravelItem(
            title: "Dubai",
            description: "Experience luxury and adventure in Dubai’s futuristic skyline. Shop in sprawling malls, relax on pristine beaches, and explore the desert. Dubai’s blend of tradition and innovation creates a unique and unforgettable travel experience.",
            imageURL: "https://picsum.photos/seed/village/200/150",
            rating: 4.7
        ),
        TravelItem(
            title: "Cape Town",
            description: "A city where mountains meet the ocean, offering breathtaking views and rich culture. Hike Table Mountain, visit vibrant neighborhoods, and enjoy world-class wines. Cape Town’s natural beauty and diverse heritage enchant visitors.",
            imageURL: "https://picsum.photos/seed/balloons/200/150",
            rating: 4.1
        ),
        TravelItem(
            title: "Rio de Janeiro",
            description: "Famous for its lively beaches, colorful festivals, and iconic Christ the Redeemer statue. Dance to samba rhythms, hike lush mountains, and soak in the city’s infectious energy. Rio’s spirit and scenery create unforgettable memories.",
            imageURL: "https://picsum.photos/seed/lake/200/150",
            rating: 3.9
        )
    ]
    
    
    //import SwiftUI
    //
    //class TravelViewModel: ObservableObject {
    //    @Published var items: [TravelItem] = [
    //        TravelItem(
    //            title: "Paris",
    //            description: """
    //Paris, the enchanting capital of France, is renowned for its timeless charm and romantic ambiance. Stroll along the Seine River and marvel at the iconic Eiffel Tower, which sparkles each evening. Explore the world-class art collections at the Louvre and the Musée d'Orsay, or wander through the bohemian streets of Montmartre. Savor fresh pastries in cozy cafés, and enjoy gourmet dining in Michelin-starred restaurants. Paris is also famous for its elegant fashion, historic architecture, and vibrant markets. Discover hidden gardens, lively squares, and charming boutiques. Whether you’re admiring Notre-Dame, shopping on the Champs-Élysées, or relaxing in Luxembourg Gardens, Paris offers unforgettable experiences at every turn.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
    //        ),
    //        TravelItem(
    //            title: "Tokyo",
    //            description: """
    //Tokyo is a dazzling metropolis where ancient traditions blend seamlessly with futuristic innovation. Experience the neon-lit energy of Shibuya Crossing and the tranquil beauty of the Meiji Shrine. Indulge in world-class sushi and ramen, and shop for the latest technology in Akihabara. Tokyo’s neighborhoods each have a unique character, from the historic temples of Asakusa to the fashionable streets of Harajuku. Explore serene gardens, vibrant markets, and quirky themed cafés. The city’s efficient transit system makes it easy to discover hidden gems, from cherry blossom parks to towering skyscrapers. Whether you seek culture, cuisine, or cutting-edge trends, Tokyo is a city that never ceases to amaze.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1465101046530-73398c7f28ca"
    //        ),
    //        TravelItem(
    //            title: "New York",
    //            description: """
    //New York City pulses with energy, diversity, and endless possibilities. Walk through Central Park, catch a Broadway show, or gaze up at the skyscrapers of Manhattan. The city’s neighborhoods—from the artsy streets of SoHo to the historic brownstones of Brooklyn—offer a world of culture and cuisine. Visit world-famous museums like the Metropolitan Museum of Art, and enjoy panoramic views from the Empire State Building. Savor street food or dine in acclaimed restaurants. New York’s nightlife, shopping, and creative spirit make it a city that truly never sleeps. Every visit reveals new stories, flavors, and unforgettable moments in the Big Apple.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1467269204594-9661b134dd2b"
    //        ),
    //        TravelItem(
    //            title: "Sydney",
    //            description: """
    //Sydney dazzles with its stunning harbor, golden beaches, and iconic landmarks. Start your day with a walk along Bondi Beach, then explore the architectural marvel of the Sydney Opera House. Take a ferry ride to Manly for breathtaking coastal views, or wander through the Royal Botanic Garden. Sydney’s neighborhoods are alive with culture, from the historic Rocks district to the vibrant markets of Paddington. Enjoy fresh seafood at Darling Harbour, and experience the city’s lively arts and music scene. With its sunny climate, outdoor adventures, and welcoming locals, Sydney is a destination that captures the heart of every traveler.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1501594907352-04cda38ebc29"
    //        ),
    //        TravelItem(
    //            title: "Rome",
    //            description: """
    //Rome, the Eternal City, is a living museum of history, art, and culture. Wander through ancient ruins like the Colosseum and Roman Forum, and toss a coin into the Trevi Fountain. Marvel at the masterpieces in the Vatican Museums and the grandeur of St. Peter’s Basilica. Rome’s cobbled streets lead to charming piazzas, bustling markets, and cozy trattorias serving authentic Italian cuisine. Sip espresso at a sidewalk café and watch the world go by. The city’s layers of history, from Renaissance palaces to Baroque fountains, create a magical atmosphere. Every corner reveals a story, making Rome a timeless destination for explorers.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1468421870903-4df1664ac249"
    //        ),
    //        TravelItem(
    //            title: "London",
    //            description: """
    //London is a vibrant tapestry of history, culture, and modern flair. Visit iconic landmarks like Big Ben, Buckingham Palace, and the Tower of London. Explore world-class museums, stroll through Hyde Park, and shop in the bustling markets of Camden and Portobello Road. The city’s diverse neighborhoods, from the creative energy of Shoreditch to the elegance of Kensington, offer endless discoveries. Enjoy afternoon tea, catch a West End show, or dine in Michelin-starred restaurants. London’s rich heritage, dynamic arts scene, and multicultural spirit make it a city that welcomes everyone. Every visit promises new adventures and lasting memories.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1505761671935-60b3a7427bad"
    //        ),
    //        TravelItem(
    //            title: "Barcelona",
    //            description: """
    //Barcelona captivates with its unique blend of art, architecture, and Mediterranean charm. Marvel at Gaudí’s masterpieces, including the Sagrada Família and Park Güell. Wander through the lively streets of the Gothic Quarter, and relax on the city’s sun-kissed beaches. Barcelona’s culinary scene is a feast for the senses, from tapas bars to bustling markets like La Boqueria. Enjoy vibrant festivals, world-class museums, and a thriving nightlife. The city’s colorful facades, tree-lined boulevards, and welcoming atmosphere invite you to explore at your own pace. Barcelona is a destination that inspires creativity and joy in every visitor.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1465156799763-2c087c332922"
    //        ),
    //        TravelItem(
    //            title: "Dubai",
    //            description: """
    //Dubai is a city of superlatives, where futuristic skyscrapers rise from the desert and luxury knows no bounds. Shop in extravagant malls, ski indoors, or ascend the world’s tallest building, the Burj Khalifa. Experience the vibrant souks, dine in gourmet restaurants, and relax on pristine beaches. Dubai’s cultural heritage shines in its museums and historic districts, while thrilling adventures await in the surrounding dunes. The city’s year-round sunshine, world-class entertainment, and innovative spirit make it a playground for travelers. Whether you seek relaxation, adventure, or luxury, Dubai offers an unforgettable escape.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee"
    //        ),
    //        TravelItem(
    //            title: "Cape Town",
    //            description: """
    //Cape Town is a city of breathtaking landscapes, rich history, and vibrant culture. Hike up Table Mountain for panoramic views, or explore the scenic Cape Peninsula. Stroll through the colorful streets of Bo-Kaap, and sample local wines in the surrounding vineyards. Cape Town’s beaches, botanical gardens, and wildlife reserves offer endless outdoor adventures. The city’s diverse cuisine, lively markets, and arts scene reflect its multicultural heritage. From historic Robben Island to the bustling V&A Waterfront, Cape Town invites you to discover its many layers. Every moment here is filled with beauty and inspiration.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1444065381814-865dc9da92c0"
    //        ),
    //        TravelItem(
    //            title: "Rio de Janeiro",
    //            description: """
    //Rio de Janeiro pulses with rhythm, color, and natural beauty. Relax on the golden sands of Copacabana and Ipanema, or hike to the summit of Sugarloaf Mountain for stunning views. The city’s iconic Christ the Redeemer statue watches over vibrant neighborhoods filled with samba music and street art. Experience the energy of Carnival, savor Brazilian cuisine, and explore lush rainforests nearby. Rio’s blend of urban excitement and breathtaking scenery creates a unique atmosphere. Whether you’re dancing at a beach party or admiring the sunset from a hillside, Rio offers unforgettable moments at every turn.
    //""",
    //            imageURL: "https://images.unsplash.com/photo-1502082553048-f009c37129b9"
    //        )
    //    ]
    //}
    //
    //
    //
}
