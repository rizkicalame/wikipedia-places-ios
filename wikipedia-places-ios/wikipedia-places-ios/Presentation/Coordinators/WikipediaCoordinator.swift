//
//  WikipediaCoordinator.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 30/09/2025.
//

import UIKit

final class WikipediaCoordinator: CoordinatorInterface {

    // MARK: - Properties

    let location: LocationDomainModel
    let navigationController: UINavigationController
    let urlOpener: URLOpenerInterface
    let errorHandler: ErrorHandlerInterface

    // MARK: - Init

    init(location: LocationDomainModel,
         navigationController: UINavigationController,
         urlOpener: URLOpenerInterface,
         errorHandler: ErrorHandlerInterface) {
        self.location = location
        self.navigationController = navigationController
        self.urlOpener = urlOpener
        self.errorHandler = errorHandler
    }

    // MARK: - CoordinatorInterface

    func start() {
        guard let url = URL(string: WikipediaDeeplinkHelper.getCoordinatesDeeplinkURL(location: location)) else {
            return
        }

        Task {
            await urlOpener.openDeeplinkURLIfPossible(url, in: navigationController, errorHandler: errorHandler)
        }
    }
}
