import UIKit

final class HomeViewController: FoundationPlaceholderViewController {
    init() {
        super.init(
            title: Localizable.Home.title,
            message: Localizable.Home.foundationMessage,
            symbolName: "house.lodge"
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
