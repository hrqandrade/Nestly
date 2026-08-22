import NestlyData
import NestlyDesignSystem
import NestlySDU
import Testing
import UIKit

@testable import Nestly

struct FoundationTests {
    @Test @MainActor func rootContainsTheThreeProductTabs() {
        let root = AppCompositionRoot.makeRootViewController() as? UITabBarController

        #expect(root?.viewControllers?.count == 3)
        #expect(root?.viewControllers?.compactMap(\.tabBarItem.title) == ["Home", "Search", "Favorites"])
    }

    @Test func currentContractVersionStartsAtOne() {
        #expect(ContractVersion.current.rawValue == 1)
    }

    @Test func fixtureLoaderReportsMissingResources() {
        #expect(throws: FixtureLoaderError.resourceNotFound("missing")) {
            try FixtureLoader().data(named: "missing", in: .main)
        }
    }

    @Test func designTokensExposeTheApprovedBrandColor() {
        #expect(NestlyColor.brandPrimary != NestlyColor.background)
    }
}
