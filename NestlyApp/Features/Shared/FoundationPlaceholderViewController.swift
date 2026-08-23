import NestlyDesignSystem
import UIKit

class FoundationPlaceholderViewController: UIViewController {
    private let message: String
    private let symbolName: String

    init(title: String, message: String, symbolName: String) {
        self.message = message
        self.symbolName = symbolName
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NestlyColor.background

        let imageView = UIImageView(image: UIImage(systemName: symbolName))
        imageView.tintColor = NestlyColor.brandPrimary
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: NestlyIconSize.prominent,
            weight: .medium
        )

        let label = UILabel()
        label.text = message
        label.font = NestlyTypography.body
        label.textColor = NestlyColor.textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true

        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = NestlySpacing.large
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: NestlyLayout.editorialMargin),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -NestlyLayout.editorialMargin)
        ])
    }
}
