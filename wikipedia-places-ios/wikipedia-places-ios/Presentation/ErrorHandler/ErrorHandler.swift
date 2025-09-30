//
//  ErrorHandler.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 30/09/2025.
//

import UIKit

protocol ErrorHandlerInterface {
    @MainActor
    func handleError(_ error: Error, in viewController: UIViewController)
}

struct ErrorHandler: ErrorHandlerInterface {
    func handleError(_ error: any Error, in viewController: UIViewController) {
        guard let localizedError = error as? LocalizedError else {
            presentGenericError(in: viewController)
            return
        }

        let alertController = createAlertController(title: localizedError.failureReason,
                                                    message: localizedError.recoverySuggestion)
        viewController.present(alertController, animated: true)
    }

    // MARK: - Private

    private func presentGenericError(in viewController: UIViewController) {
        let alertController = createAlertController(title: "Something went wrong",
                                                    message: "Please try again later.")
        viewController.present(alertController, animated: true)
    }

    private func createAlertController(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .cancel)
        alertController.addAction(action)
        return alertController
    }
}
