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
    let deeplinkOpener: WikipediaDeeplinkURLOpenerInterface
    let errorHandler: ErrorHandlerInterface

    // MARK: - Init

    init(location: LocationDomainModel,
         navigationController: UINavigationController,
         deeplinkOpener: WikipediaDeeplinkURLOpenerInterface,
         errorHandler: ErrorHandlerInterface) {
        self.location = location
        self.navigationController = navigationController
        self.deeplinkOpener = deeplinkOpener
        self.errorHandler = errorHandler
    }

    // MARK: - CoordinatorInterface

    func start() {
        Task {
            await deeplinkOpener.openDeeplinkWithCoordinatesIfPossible(latitude: location.latitude,
                                                                       longitude: location.longitude,
                                                                       in: navigationController,
                                                                       errorHandler: errorHandler)
        }
    }
}
