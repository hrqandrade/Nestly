import UIKit

final class FavoritesViewController: FoundationPlaceholderViewController {
    init() {
        super.init(
            title: Localizable.Favorites.title,
            message: Localizable.Favorites.foundationMessage,
            symbolName: "heart"
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
