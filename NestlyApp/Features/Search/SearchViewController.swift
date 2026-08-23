import UIKit

final class SearchViewController: FoundationPlaceholderViewController {
    init() {
        super.init(
            title: Localizable.Search.title,
            message: Localizable.Search.foundationMessage,
            symbolName: "magnifyingglass"
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
