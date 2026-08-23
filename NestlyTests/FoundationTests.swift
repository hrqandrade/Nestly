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
        #expect(
            root?.viewControllers?.compactMap(\.tabBarItem.title) == [
                Localizable.Tab.home,
                Localizable.Tab.search,
                Localizable.Tab.favorites
            ]
        )
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

    @Test func layoutTokensPreserveMinimumInteractionSize() {
        #expect(NestlyLayout.minimumTouchTarget == 44)
        #expect(NestlyRadius.propertyCard == NestlySpacing.large)
    }

    @Test func productStringsResolveFromTheCatalog() {
        #expect(!Localizable.Home.title.isEmpty)
        #expect(!Localizable.Search.foundationMessage.isEmpty)
        #expect(!Localizable.Favorites.title.isEmpty)
    }
}
