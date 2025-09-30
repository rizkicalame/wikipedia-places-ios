//
//  URLOpener.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 30/09/2025.
//

import UIKit

protocol WikipediaDeeplinkURLOpenerInterface {
    @MainActor
    func openDeeplinkWithCoordinatesIfPossible(latitude: Double,
                                               longitude: Double,
                                               in viewController: UIViewController,
                                               errorHandler: ErrorHandlerInterface) async
    func getCoordinatesDeeplinkURL(latitude: Double, longitude: Double) -> URL?
}

struct WikipediaDeeplinkURLOpener: WikipediaDeeplinkURLOpenerInterface {

    // MARK: - Constants

    enum DeeplinkConstants {
        static let appHostScheme = "wikipedia"
        static let placesIntent = "places"
        static let coordinatesQueryParameter = "WMFPlacesCoordinates"
    }

    // MARK: - Errors
    
    enum Errors: LocalizedError {
        case invalidCoordinatesUsed
        case urlNotValid
        case unableToDeeplink

        // MARK: - LocalizedError

        var failureReason: String? {
            switch self {
            case .invalidCoordinatesUsed: return "Oops! Invalid coordinates used."
            case .urlNotValid: return "Oops! Unable to open the provided location."
            case .unableToDeeplink: return "Oops! Deeplinking failed."
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .invalidCoordinatesUsed: return "Please check if the coordinates used are valid."
            case .urlNotValid: return "Please try again later."
            case .unableToDeeplink: return "We weren't able to deeplinking to the Wikipedia app. Please ensure you have the Wikipedia app installed."
            }
        }
    }

    // MARK: - Properties

    private let urlOpener: any URLOpening

    init(urlOpener: any URLOpening = URLOpener()) {
        self.urlOpener = urlOpener
    }

    // MARK: - URLOpenerInterface

    func openDeeplinkWithCoordinatesIfPossible(latitude: Double,
                                               longitude: Double,
                                               in viewController: UIViewController,
                                               errorHandler: ErrorHandlerInterface) async {
        guard let url = getCoordinatesDeeplinkURL(latitude: latitude, longitude: longitude) else {
            errorHandler.handleError(Errors.invalidCoordinatesUsed, in: viewController)
            return
        }

        guard urlOpener.canOpenURL(url) else {
            errorHandler.handleError(Errors.urlNotValid, in: viewController)
            return
        }

        let success = await urlOpener.openURL(url)

        if !success {
            errorHandler.handleError(Errors.unableToDeeplink, in: viewController)
        }
    }

    /// Constructs the deeplinking URL specifically for the Wikipedia app.
    /// - Parameter latitude: The latitude.
    /// - Parameter longitude: The longitude.
    /// - Returns: A string presentation of the deeplinking URL to the Wikipedia app.
    func getCoordinatesDeeplinkURL(latitude: Double, longitude: Double) -> URL? {
        let lat = String(latitude)
        let lon = String(longitude)
        var components = URLComponents()
        components.scheme = DeeplinkConstants.appHostScheme
        components.host = DeeplinkConstants.placesIntent
        components.path = "/"
        components.queryItems = [
            URLQueryItem(name: DeeplinkConstants.coordinatesQueryParameter, value: "\(lat),\(lon)")
        ]
        return components.url
    }
}
