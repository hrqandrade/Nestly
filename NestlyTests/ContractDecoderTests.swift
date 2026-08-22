import Foundation
import NestlyData
import NestlySDU
import Testing

struct ContractDecoderTests {
    private let decoder = ContractDecoder()
    private let adapter = ContractAdapter()

    @Test func validHomeDecodesAndAdaptsIntoSafeModels() throws {
        let response = try decoder.decodeHome(from: fixture("valid-home"))
        let result = try adapter.adapt(response)

        #expect(result.value.id == "urban-rentals")
        #expect(result.value.sections.map(\.kind) == [.heroBanner, .divider])
        #expect(result.value.sections.first?.variant == .imageOverlay)
        #expect(result.value.sections.first?.action?.kind == .openSearch)
        #expect(result.issues.isEmpty)
    }

    @Test func partialHomeKeepsValidComponentsAndReportsIsolatedFailures() throws {
        let response = try decoder.decodeHome(from: fixture("partial-home"))
        let result = try adapter.adapt(response)

        #expect(result.value.sections.count == 2)
        #expect(result.value.sections.map(\.id) == ["valid-title", "invalid-action"])
        #expect(result.value.sections.last?.action == nil)
        #expect(result.issues.contains(.unsupportedComponent(id: "unsupported", type: "remoteCustomView")))
        #expect(result.issues.contains(.invalidActionPayload(componentId: "invalid-action", type: .openProperty)))
        #expect(result.issues.contains(.missingContent(id: "missing-content")))
        #expect(result.issues.contains(.duplicateIdentifier("valid-title")))
    }

    @Test func contentPageUsesTheSameSafeComponentBoundary() throws {
        let response = try decoder.decodeContentPage(from: fixture("valid-content-page"))
        let result = try adapter.adapt(response)

        #expect(result.value.id == "first-home-guide")
        #expect(result.value.components.count == 2)
        #expect(result.value.finalAction?.kind == .applyFilter)
        #expect(result.value.relatedPropertyIds == ["property-101", "property-102"])
        #expect(result.issues.isEmpty)
    }

    @Test func unsupportedVersionRejectsTheCompleteResponse() throws {
        let response = try decoder.decodeHome(from: fixture("unsupported-version-home"))

        #expect(throws: ContractAdaptationError.unsupportedSchemaVersion(2)) {
            try adapter.adapt(response)
        }
    }

    @Test func malformedPayloadHasAControlledError() {
        let malformed = Data(#"{"schemaVersion":1,"sections":}"#.utf8)

        #expect(throws: ContractDecodingError.malformedPayload) {
            try decoder.decodeHome(from: malformed)
        }
    }

    @Test func unsafeExternalURLIsRemovedFromAnOtherwiseValidComponent() throws {
        let payload = Data(#"{"schemaVersion":1,"experienceId":"safe","sections":[{"id":"cta","type":"callToAction","content":{"title":"Open"},"action":{"type":"openSafeURL","presentationStyle":"externalHandoff","destination":"javascript:alert(1)"}}]}"#.utf8)
        let result = try adapter.adapt(decoder.decodeHome(from: payload))

        #expect(result.value.sections.count == 1)
        #expect(result.value.sections[0].action == nil)
        #expect(result.issues == [.invalidActionPayload(componentId: "cta", type: .openSafeURL)])
    }

    @Test func restrictedPresentationKeysRejectOnlyTheirComponent() throws {
        let payload = Data(#"{"schemaVersion":1,"experienceId":"safe","sections":[{"id":"unsafe","type":"heroBanner","content":{"title":"Title","fontSize":80}},{"id":"safe-divider","type":"divider"}]}"#.utf8)
        let result = try adapter.adapt(decoder.decodeHome(from: payload))

        #expect(result.value.sections.map(\.id) == ["safe-divider"])
        #expect(result.issues == [.restrictedContent(id: "unsafe")])
    }

    private func fixture(_ name: String) throws -> Data {
        try FixtureLoader().data(named: name, in: .main)
    }
}
