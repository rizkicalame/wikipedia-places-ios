import UIKit

/// Root view controller for the entire app. Handles splash screen presentation.
@objc(WMFRootNavigationController)
class RootNavigationController: WMFThemeableNavigationController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .all
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }

    func pruneSearchControllers() {
        let count = viewControllers.count
        guard count - 2 > 1 else {
            return
        }

        /// `1..<count-2`: If first controller is Search (from tab bar item Search), it must be kept. Also, if VC prior to top one is Search, it is kept.
        viewControllers[1..<count-2].forEach({ ($0 as? SearchViewController)?.removeFromParent() })
    }

}
