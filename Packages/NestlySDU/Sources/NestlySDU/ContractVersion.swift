public struct ContractVersion: RawRepresentable, Equatable, Sendable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let current = ContractVersion(rawValue: 1)
}

public enum ContractVersionPolicy: Sendable {
    public static func supports(_ version: Int) -> Bool {
        version == ContractVersion.current.rawValue
    }
}
