// Generated using Sourcery 2.2.5 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
@testable import wikipedia_places_ios 
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























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
    var createCustomLocationLocationClosure: ((LocationDomainModel) -> Void)?

    func createCustomLocation(location: LocationDomainModel) {
        createCustomLocationLocationCallsCount += 1
        createCustomLocationLocationReceivedLocation = location
        createCustomLocationLocationReceivedInvocations.append(location)
        createCustomLocationLocationClosure?(location)
    }

}
