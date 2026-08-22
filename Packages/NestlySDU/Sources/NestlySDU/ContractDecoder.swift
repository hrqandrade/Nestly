import Foundation

public enum ContractDecodingError: Error, Equatable {
    case malformedPayload
}

public struct ContractDecoder: Sendable {
    private let decoder: JSONDecoder

    public init() { decoder = JSONDecoder() }

    public func decodeHome(from data: Data) throws -> HomeResponseDTO {
        try decode(HomeResponseDTO.self, from: data)
    }

    public func decodeContentPage(from data: Data) throws -> ContentPageResponseDTO {
        try decode(ContentPageResponseDTO.self, from: data)
    }

    private func decode<Value: Decodable>(_ type: Value.Type, from data: Data) throws -> Value {
        do { return try decoder.decode(type, from: data) }
        catch { throw ContractDecodingError.malformedPayload }
    }
}
