import Foundation

public enum FixtureLoaderError: Error, Equatable {
    case resourceNotFound(String)
}

public struct FixtureLoader: Sendable {
    public init() {}

    public func data(named name: String, in bundle: Bundle) throws -> Data {
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            throw FixtureLoaderError.resourceNotFound(name)
        }
        return try Data(contentsOf: url)
    }
}

