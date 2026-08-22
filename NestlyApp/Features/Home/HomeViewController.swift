import UIKit

final class HomeViewController: FoundationPlaceholderViewController {
    init() {
        super.init(message: "Your next place starts here.", symbolName: "house.lodge")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

