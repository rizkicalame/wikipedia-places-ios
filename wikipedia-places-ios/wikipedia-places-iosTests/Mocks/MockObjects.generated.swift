// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
@testable import wikipedia_places_ios 
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























class AddCustomLocationUseCaseInterfaceMock: AddCustomLocationUseCaseInterface {




    //MARK: - addCustomLocation

    var addCustomLocationNameLatitudeLongitudeThrowableError: Error?
    var addCustomLocationNameLatitudeLongitudeCallsCount = 0
    var addCustomLocationNameLatitudeLongitudeCalled: Bool {
        return addCustomLocationNameLatitudeLongitudeCallsCount > 0
    }
    var addCustomLocationNameLatitudeLongitudeReceivedArguments: (name: String?, latitude: String, longitude: String)?
    var addCustomLocationNameLatitudeLongitudeReceivedInvocations: [(name: String?, latitude: String, longitude: String)] = []
    var addCustomLocationNameLatitudeLongitudeClosure: ((String?, String, String) async throws -> Void)?

    func addCustomLocation(name: String?, latitude: String, longitude: String) async throws {
        addCustomLocationNameLatitudeLongitudeCallsCount += 1
        addCustomLocationNameLatitudeLongitudeReceivedArguments = (name: name, latitude: latitude, longitude: longitude)
        addCustomLocationNameLatitudeLongitudeReceivedInvocations.append((name: name, latitude: latitude, longitude: longitude))
        if let error = addCustomLocationNameLatitudeLongitudeThrowableError {
            throw error
        }
        try await addCustomLocationNameLatitudeLongitudeClosure?(name, latitude, longitude)
    }

}
class BaseDependenciesInterfaceMock: BaseDependenciesInterface {


    var apiClient: APIClientInterface {
        get { return underlyingApiClient }
        set(value) { underlyingApiClient = value }
    }
    var underlyingApiClient: (APIClientInterface)!
    var customLocationsCache: CustomLocationsCacheInterface {
        get { return underlyingCustomLocationsCache }
        set(value) { underlyingCustomLocationsCache = value }
    }
    var underlyingCustomLocationsCache: (CustomLocationsCacheInterface)!
    var urlOpener: URLOpenerInterface {
        get { return underlyingUrlOpener }
        set(value) { underlyingUrlOpener = value }
    }
    var underlyingUrlOpener: (URLOpenerInterface)!
    var errorHandler: ErrorHandlerInterface {
        get { return underlyingErrorHandler }
        set(value) { underlyingErrorHandler = value }
    }
    var underlyingErrorHandler: (ErrorHandlerInterface)!


}
class ErrorHandlerInterfaceMock: ErrorHandlerInterface {




    //MARK: - handleError

    var handleErrorInCallsCount = 0
    var handleErrorInCalled: Bool {
        return handleErrorInCallsCount > 0
    }
    var handleErrorInReceivedArguments: (error: Error, viewController: UIViewController)?
    var handleErrorInReceivedInvocations: [(error: Error, viewController: UIViewController)] = []
    var handleErrorInClosure: ((Error, UIViewController) -> Void)?

    @MainActor
    func handleError(_ error: Error, in viewController: UIViewController) {
        handleErrorInCallsCount += 1
        handleErrorInReceivedArguments = (error: error, viewController: viewController)
        handleErrorInReceivedInvocations.append((error: error, viewController: viewController))
        handleErrorInClosure?(error, viewController)
    }

}
class GetLocationsUseCaseInterfaceMock: GetLocationsUseCaseInterface {




    //MARK: - getLocations

    var getLocationsThrowableError: Error?
    var getLocationsCallsCount = 0
    var getLocationsCalled: Bool {
        return getLocationsCallsCount > 0
    }
    var getLocationsReturnValue: [LocationDomainModel]!
    var getLocationsClosure: (() async throws -> [LocationDomainModel])?

    func getLocations() async throws -> [LocationDomainModel] {
        getLocationsCallsCount += 1
        if let error = getLocationsThrowableError {
            throw error
        }
        if let getLocationsClosure = getLocationsClosure {
            return try await getLocationsClosure()
        } else {
            return getLocationsReturnValue
        }
    }

}
class LocationsRepositoryInterfaceMock: LocationsRepositoryInterface {




    //MARK: - getLocations

    var getLocationsThrowableError: Error?
    var getLocationsCallsCount = 0
    var getLocationsCalled: Bool {
        return getLocationsCallsCount > 0
    }
    var getLocationsReturnValue: [LocationDomainModel]!
    var getLocationsClosure: (() async throws -> [LocationDomainModel])?

    func getLocations() async throws -> [LocationDomainModel] {
        getLocationsCallsCount += 1
        if let error = getLocationsThrowableError {
            throw error
        }
        if let getLocationsClosure = getLocationsClosure {
            return try await getLocationsClosure()
        } else {
            return getLocationsReturnValue
        }
    }

    //MARK: - createCustomLocation

    var createCustomLocationLocationCallsCount = 0
    var createCustomLocationLocationCalled: Bool {
        return createCustomLocationLocationCallsCount > 0
    }
    var createCustomLocationLocationReceivedLocation: (LocationDomainModel)?
    var createCustomLocationLocationReceivedInvocations: [(LocationDomainModel)] = []
    var createCustomLocationLocationClosure: ((LocationDomainModel) async -> Void)?

    func createCustomLocation(location: LocationDomainModel) async {
        createCustomLocationLocationCallsCount += 1
        createCustomLocationLocationReceivedLocation = location
        createCustomLocationLocationReceivedInvocations.append(location)
        await createCustomLocationLocationClosure?(location)
    }

}
class URLOpenerInterfaceMock: URLOpenerInterface {




    //MARK: - openDeeplinkURLIfPossible

    var openDeeplinkURLIfPossibleInErrorHandlerCallsCount = 0
    var openDeeplinkURLIfPossibleInErrorHandlerCalled: Bool {
        return openDeeplinkURLIfPossibleInErrorHandlerCallsCount > 0
    }
    var openDeeplinkURLIfPossibleInErrorHandlerReceivedArguments: (url: URL, viewController: UIViewController, errorHandler: ErrorHandlerInterface)?
    var openDeeplinkURLIfPossibleInErrorHandlerReceivedInvocations: [(url: URL, viewController: UIViewController, errorHandler: ErrorHandlerInterface)] = []
    var openDeeplinkURLIfPossibleInErrorHandlerClosure: ((URL, UIViewController, ErrorHandlerInterface) async -> Void)?

    @MainActor
    func openDeeplinkURLIfPossible(_ url: URL, in viewController: UIViewController, errorHandler: ErrorHandlerInterface) async {
        openDeeplinkURLIfPossibleInErrorHandlerCallsCount += 1
        openDeeplinkURLIfPossibleInErrorHandlerReceivedArguments = (url: url, viewController: viewController, errorHandler: errorHandler)
        openDeeplinkURLIfPossibleInErrorHandlerReceivedInvocations.append((url: url, viewController: viewController, errorHandler: errorHandler))
        await openDeeplinkURLIfPossibleInErrorHandlerClosure?(url, viewController, errorHandler)
    }

}
