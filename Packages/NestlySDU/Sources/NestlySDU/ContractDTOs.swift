import Foundation

public struct HomeResponseDTO: Decodable, Equatable, Sendable {
    public let schemaVersion: Int
    public let experienceId: String
    public let metadata: DisplayMetadataDTO?
    public let sections: [ComponentDTO]
    public let fallback: FallbackMetadataDTO?
    public let analyticsId: String?
}

public struct ContentPageResponseDTO: Decodable, Equatable, Sendable {
    public let schemaVersion: Int
    public let pageId: String
    public let title: String?
    public let components: [ComponentDTO]
    public let finalAction: ActionDTO?
    public let relatedPropertyIds: [String]?
}

public struct DisplayMetadataDTO: Decodable, Equatable, Sendable {
    public let title: String?
    public let subtitle: String?
}

public struct FallbackMetadataDTO: Decodable, Equatable, Sendable {
    public let title: String?
    public let message: String?
}

public struct ComponentDTO: Decodable, Equatable, Sendable {
    public let id: String?
    public let type: String
    public let variant: String?
    public let content: [String: JSONValue]?
    public let action: ActionDTO?
    public let accessibilityLabel: String?
    public let spacing: String?
    public let visibility: VisibilityDTO?
}

public struct VisibilityDTO: Decodable, Equatable, Sendable {
    public let isHidden: Bool?
}

public struct ActionDTO: Decodable, Equatable, Sendable {
    public let type: String
    public let presentationStyle: String?
    public let destination: String?
    public let payload: [String: JSONValue]?
    public let confirmation: ConfirmationDTO?
    public let fallback: FallbackMetadataDTO?
}

public struct ConfirmationDTO: Decodable, Equatable, Sendable {
    public let title: String
    public let message: String
    public let confirmTitle: String?
    public let cancelTitle: String?
}
