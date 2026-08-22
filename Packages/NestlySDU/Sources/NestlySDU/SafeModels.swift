import Foundation

public enum SDUComponentKind: String, CaseIterable, Sendable {
    case sectionHeader, spacer, divider, callToAction, informationalCard
    case heroBanner, quickFilters, featuredProperty, propertyCarousel, propertyList
    case locationCarousel, promotionalBanner, recentlyViewed, stepGuide, assistanceBanner
    case contentHero, contentTitle, richText, iconList, numberedSteps, imageGallery
    case highlightCard, faq, relatedProperties, contentCTA
}

public enum ComponentVariant: String, CaseIterable, Sendable {
    case compact, standard, featured, editorial, imageOverlay, imageBelowText, split
    case neutral, educational, assistance, warning, fullBleed
}

public enum SpacingToken: String, CaseIterable, Sendable {
    case none, extraSmall, small, medium, large, extraLarge
}

public enum PresentationStyle: String, CaseIterable, Sendable {
    case push, modal, bottomSheet, replaceHome, openTab, externalHandoff
}

public enum ActionKind: String, CaseIterable, Sendable {
    case openProperty, openSearch, openFavorites, openScheduleVisit, openTab
    case openContentPage, reloadHome, applyFilter, openPropertyCollection
    case presentBottomSheet, presentConfirmation, presentGallery, presentSuccess
    case toggleFavorite, changeLocation, changeIntent, refreshContent
    case openSafeURL, openWhatsApp
}

public struct SafeAction: Equatable, Sendable {
    public let kind: ActionKind
    public let presentationStyle: PresentationStyle?
    public let destination: String?
    public let payload: [String: JSONValue]
    public let confirmation: ConfirmationDTO?
    public let fallback: FallbackMetadataDTO?
}

public struct SafeComponent: Identifiable, Equatable, Sendable {
    public let id: String
    public let kind: SDUComponentKind
    public let variant: ComponentVariant?
    public let content: [String: JSONValue]
    public let action: SafeAction?
    public let accessibilityLabel: String?
    public let spacing: SpacingToken?
}

public struct HomeExperience: Equatable, Sendable {
    public let id: String
    public let metadata: DisplayMetadataDTO?
    public let sections: [SafeComponent]
    public let fallback: FallbackMetadataDTO?
    public let analyticsId: String?
}

public struct ContentPage: Equatable, Sendable {
    public let id: String
    public let title: String?
    public let components: [SafeComponent]
    public let finalAction: SafeAction?
    public let relatedPropertyIds: [String]
}

public enum ContractIssue: Equatable, Sendable {
    case missingIdentifier(index: Int)
    case duplicateIdentifier(String)
    case unsupportedComponent(id: String?, type: String)
    case unsupportedVariant(id: String, variant: String)
    case missingContent(id: String)
    case restrictedContent(id: String)
    case unsupportedSpacing(id: String, spacing: String)
    case unsupportedAction(componentId: String?, type: String)
    case invalidActionPayload(componentId: String?, type: ActionKind)
}

public struct AdaptationResult<Value: Equatable & Sendable>: Equatable, Sendable {
    public let value: Value
    public let issues: [ContractIssue]
}

public enum ContractAdaptationError: Error, Equatable {
    case unsupportedSchemaVersion(Int)
    case missingResponseIdentifier
}
