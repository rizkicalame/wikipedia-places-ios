//
//  URLOpener.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 30/09/2025.
//

import UIKit

protocol URLOpenerInterface {
    @MainActor
    func openDeeplinkURLIfPossible(_ url: URL,
                                   in viewController: UIViewController,
                                   errorHandler: ErrorHandlerInterface) async
}

struct URLOpener: URLOpenerInterface {

    // MARK: - Errors
    
    enum Errors: LocalizedError {
        case wikipediaURLNotValid
        case unableToDeeplink

        // MARK: - LocalizedError

        var reason: String {
            switch self {
            case .wikipediaURLNotValid: return "Oops! Unable to open the provided location."
            case .unableToDeeplink: return "Oops! Deeplinking failed."
            }
        }

        var recoverySuggestion: String {
            switch self {
            case .wikipediaURLNotValid: return "Please try again later."
            case .unableToDeeplink: return "We weren't able to deeplinking to the Wikipedia app. Please ensure you have the Wikipedia app installed."
            }
        }
    }

    // MARK: - URLOpenerInterface

    func openDeeplinkURLIfPossible(_ url: URL,
                                   in viewController: UIViewController,
                                   errorHandler: ErrorHandlerInterface) async {
        guard UIApplication.shared.canOpenURL(url) else {
            errorHandler.handleError(Errors.wikipediaURLNotValid, in: viewController)
            return
        }

        let success = await UIApplication.shared.open(url, options: [:])

        if !success {
            errorHandler.handleError(Errors.unableToDeeplink, in: viewController)
        }
    }
}
