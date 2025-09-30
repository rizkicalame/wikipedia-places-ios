//
//  BaseDependencies.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 29/09/2025.
//

protocol BaseDependenciesInterface {
    var apiClient: APIClientInterface { get }
    var customLocationsCache: CustomLocationsCacheInterface { get }
    var deeplinkOpener: WikipediaDeeplinkURLOpenerInterface { get }
    var errorHandler: ErrorHandlerInterface { get }
}

struct BaseDependencies: BaseDependenciesInterface {

    // MARK: - BaseDependenciesInterface

    var apiClient: any APIClientInterface
    var customLocationsCache: any CustomLocationsCacheInterface
    var deeplinkOpener: any WikipediaDeeplinkURLOpenerInterface
    var errorHandler: any ErrorHandlerInterface

    // MARK: - Init

    init(apiClient: any APIClientInterface,
         customLocationsCache: any CustomLocationsCacheInterface,
         deeplinkOpener: any WikipediaDeeplinkURLOpenerInterface,
         errorHandler: any ErrorHandlerInterface) {
        self.apiClient = apiClient
        self.customLocationsCache = customLocationsCache
        self.deeplinkOpener = deeplinkOpener
        self.errorHandler = errorHandler
    }

    // MARK: - Static

    /// Make the expected configurations through a utility method.
    /// - Returns: Bootstrapped dependencies.
    static func bootstrap() -> BaseDependencies {
        let apiClient = APIClient(baseURL: Configuration.value(for: .apiURL))
        let customLocationsCache = CustomLocationsCache()
        let deeplinkOpener = WikipediaDeeplinkURLOpener()
        let errorHandler = ErrorHandler()
        return BaseDependencies(apiClient: apiClient,
                                customLocationsCache: customLocationsCache,
                                deeplinkOpener: deeplinkOpener,
                                errorHandler: errorHandler)
    }
}
