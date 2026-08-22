public struct ContractVersion: RawRepresentable, Equatable, Sendable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let current = ContractVersion(rawValue: 1)
}

