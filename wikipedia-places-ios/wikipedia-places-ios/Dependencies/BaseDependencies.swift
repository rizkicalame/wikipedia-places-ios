//
//  BaseDependencies.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 29/09/2025.
//

protocol BaseDependenciesInterface {
    var apiClient: APIClientInterface { get }
    var customLocationsCache: CustomLocationsCacheInterface { get }
    var urlOpener: URLOpenerInterface { get }
    var errorHandler: ErrorHandlerInterface { get }
}

struct BaseDependencies: BaseDependenciesInterface {

    // MARK: - BaseDependenciesInterface

    var apiClient: any APIClientInterface
    var customLocationsCache: any CustomLocationsCacheInterface
    var urlOpener: any URLOpenerInterface
    var errorHandler: any ErrorHandlerInterface

    // MARK: - Init

    init(apiClient: any APIClientInterface,
         customLocationsCache: any CustomLocationsCacheInterface,
         urlOpener: any URLOpenerInterface,
         errorHandler: any ErrorHandlerInterface) {
        self.apiClient = apiClient
        self.customLocationsCache = customLocationsCache
        self.urlOpener = urlOpener
        self.errorHandler = errorHandler
    }

    // MARK: - Static

    /// Make the expected configurations through a utility method.
    /// - Returns: Bootstrapped dependencies.
    static func bootstrap() -> BaseDependencies {
        let apiClient = APIClient(baseURL: Configuration.value(for: .apiURL))
        let customLocationsCache = CustomLocationsCache()
        let urlOpener = URLOpener()
        let errorHandler = ErrorHandler()
        return BaseDependencies(apiClient: apiClient,
                                customLocationsCache: customLocationsCache,
                                urlOpener: urlOpener,
                                errorHandler: errorHandler)
    }
}
