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
