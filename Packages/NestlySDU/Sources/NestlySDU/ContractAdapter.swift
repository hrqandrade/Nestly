import Foundation

public struct ContractAdapter: Sendable {
    public init() {}

    public func adapt(_ response: HomeResponseDTO) throws -> AdaptationResult<HomeExperience> {
        try validate(version: response.schemaVersion)
        let id = try validatedResponseIdentifier(response.experienceId)
        let result = adaptComponents(response.sections)
        return AdaptationResult(
            value: HomeExperience(id: id, metadata: response.metadata, sections: result.components, fallback: response.fallback, analyticsId: response.analyticsId),
            issues: result.issues
        )
    }

    public func adapt(_ response: ContentPageResponseDTO) throws -> AdaptationResult<ContentPage> {
        try validate(version: response.schemaVersion)
        let id = try validatedResponseIdentifier(response.pageId)
        let result = adaptComponents(response.components)
        let finalAction = adaptAction(response.finalAction, componentId: nil)
        return AdaptationResult(
            value: ContentPage(id: id, title: response.title, components: result.components, finalAction: finalAction.action, relatedPropertyIds: response.relatedPropertyIds ?? []),
            issues: result.issues + finalAction.issues
        )
    }

    private func validate(version: Int) throws {
        guard ContractVersionPolicy.supports(version) else { throw ContractAdaptationError.unsupportedSchemaVersion(version) }
    }

    private func validatedResponseIdentifier(_ id: String) throws -> String {
        let trimmed = id.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw ContractAdaptationError.missingResponseIdentifier }
        return trimmed
    }

    private func adaptComponents(_ components: [ComponentDTO]) -> (components: [SafeComponent], issues: [ContractIssue]) {
        var identifiers = Set<String>()
        var safeComponents: [SafeComponent] = []
        var issues: [ContractIssue] = []

        for (index, component) in components.enumerated() {
            guard let id = component.id?.trimmingCharacters(in: .whitespacesAndNewlines), !id.isEmpty else {
                issues.append(.missingIdentifier(index: index)); continue
            }
            guard identifiers.insert(id).inserted else { issues.append(.duplicateIdentifier(id)); continue }
            guard let kind = SDUComponentKind(rawValue: component.type) else {
                issues.append(.unsupportedComponent(id: component.id, type: component.type)); continue
            }
            if component.visibility?.isHidden == true { continue }
            let content = component.content ?? [:]
            if requiresContent(kind), content.isEmpty { issues.append(.missingContent(id: id)); continue }
            if containsRestrictedContent(content) { issues.append(.restrictedContent(id: id)); continue }

            var variant: ComponentVariant?
            if let rawVariant = component.variant {
                if let candidate = ComponentVariant(rawValue: rawVariant), supports(candidate, for: kind) { variant = candidate }
                else { issues.append(.unsupportedVariant(id: id, variant: rawVariant)) }
            }
            var spacing: SpacingToken?
            if let rawSpacing = component.spacing {
                if let candidate = SpacingToken(rawValue: rawSpacing) { spacing = candidate }
                else { issues.append(.unsupportedSpacing(id: id, spacing: rawSpacing)) }
            }
            let action = adaptAction(component.action, componentId: id)
            issues.append(contentsOf: action.issues)
            safeComponents.append(SafeComponent(id: id, kind: kind, variant: variant, content: content, action: action.action, accessibilityLabel: component.accessibilityLabel, spacing: spacing))
        }
        return (safeComponents, issues)
    }

    private func adaptAction(_ dto: ActionDTO?, componentId: String?) -> (action: SafeAction?, issues: [ContractIssue]) {
        guard let dto else { return (nil, []) }
        guard let kind = ActionKind(rawValue: dto.type) else {
            return (nil, [.unsupportedAction(componentId: componentId, type: dto.type)])
        }
        let presentation = dto.presentationStyle.flatMap(PresentationStyle.init(rawValue:))
        if dto.presentationStyle != nil, presentation == nil {
            return (nil, [.invalidActionPayload(componentId: componentId, type: kind)])
        }
        guard validatesDestination(dto.destination, for: kind) else {
            return (nil, [.invalidActionPayload(componentId: componentId, type: kind)])
        }
        return (SafeAction(kind: kind, presentationStyle: presentation, destination: dto.destination, payload: dto.payload ?? [:], confirmation: dto.confirmation, fallback: dto.fallback), [])
    }

    private func validatesDestination(_ destination: String?, for kind: ActionKind) -> Bool {
        let required: Set<ActionKind> = [.openProperty, .openTab, .openContentPage, .reloadHome, .applyFilter, .openPropertyCollection, .changeLocation, .changeIntent, .openSafeURL, .openWhatsApp]
        guard required.contains(kind) else { return true }
        guard let destination, !destination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        if kind == .openSafeURL {
            guard let url = URL(string: destination), url.scheme == "https", url.host != nil else { return false }
        }
        return true
    }

    private func requiresContent(_ kind: SDUComponentKind) -> Bool { kind != .spacer && kind != .divider }

    private func containsRestrictedContent(_ content: [String: JSONValue]) -> Bool {
        let restricted = Set(["fontSize", "rawColor", "hexColor", "html", "script", "className"])
        return content.contains { restricted.contains($0.key) || containsRestrictedContent($0.value) }
    }

    private func containsRestrictedContent(_ value: JSONValue) -> Bool {
        switch value {
        case let .object(object): return containsRestrictedContent(object)
        case let .array(values): return values.contains(where: containsRestrictedContent)
        default: return false
        }
    }

    private func supports(_ variant: ComponentVariant, for kind: SDUComponentKind) -> Bool {
        switch kind {
        case .featuredProperty, .propertyCarousel, .propertyList, .recentlyViewed, .relatedProperties:
            return [.compact, .standard, .featured, .editorial, .fullBleed].contains(variant)
        case .heroBanner, .contentHero:
            return [.imageOverlay, .imageBelowText, .editorial, .split].contains(variant)
        case .informationalCard, .highlightCard, .assistanceBanner:
            return [.neutral, .educational, .assistance, .warning].contains(variant)
        case .locationCarousel, .imageGallery:
            return [.compact, .standard, .fullBleed].contains(variant)
        default:
            return variant == .standard
        }
    }
}
