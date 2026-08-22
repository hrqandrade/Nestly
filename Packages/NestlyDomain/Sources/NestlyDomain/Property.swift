import Foundation

public struct Property: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let city: String

    public init(id: String, title: String, city: String) {
        self.id = id
        self.title = title
        self.city = city
    }
}

