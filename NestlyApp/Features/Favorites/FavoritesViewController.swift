import UIKit

final class FavoritesViewController: FoundationPlaceholderViewController {
    init() {
        super.init(message: "Saved properties will appear here.", symbolName: "heart")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

