import Foundation

enum Localizable {
    enum Tab {
        static var home: String {
            String(localized: "tab.home", defaultValue: "Home", bundle: .main)
        }

        static var search: String {
            String(localized: "tab.search", defaultValue: "Search", bundle: .main)
        }

        static var favorites: String {
            String(localized: "tab.favorites", defaultValue: "Favorites", bundle: .main)
        }
    }

    enum Home {
        static var title: String {
            String(localized: "home.title", defaultValue: "Home", bundle: .main)
        }

        static var foundationMessage: String {
            String(localized: "home.foundation.message", defaultValue: "Your next place starts here.", bundle: .main)
        }
    }

    enum Search {
        static var title: String {
            String(localized: "search.title", defaultValue: "Search", bundle: .main)
        }

        static var foundationMessage: String {
            String(localized: "search.foundation.message", defaultValue: "Search will arrive in the native screens phase.", bundle: .main)
        }
    }

    enum Favorites {
        static var title: String {
            String(localized: "favorites.title", defaultValue: "Favorites", bundle: .main)
        }

        static var foundationMessage: String {
            String(localized: "favorites.foundation.message", defaultValue: "Saved properties will appear here.", bundle: .main)
        }
    }
}
