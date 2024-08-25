// Generated using Sourcery 2.2.5 — https://github.com/krzysztofzablocki/Sourcery
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
    var addCustomLocationNameLatitudeLongitudeClosure: ((String?, String, String) throws -> Void)?

    func addCustomLocation(name: String?, latitude: String, longitude: String) throws {
        addCustomLocationNameLatitudeLongitudeCallsCount += 1
        addCustomLocationNameLatitudeLongitudeReceivedArguments = (name: name, latitude: latitude, longitude: longitude)
        addCustomLocationNameLatitudeLongitudeReceivedInvocations.append((name: name, latitude: latitude, longitude: longitude))
        if let error = addCustomLocationNameLatitudeLongitudeThrowableError {
            throw error
        }
        try addCustomLocationNameLatitudeLongitudeClosure?(name, latitude, longitude)
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
class HomeViewModelDelegateMock: HomeViewModelDelegate {




    //MARK: - didTapAddCustomLocation

    var didTapAddCustomLocationSenderCallsCount = 0
    var didTapAddCustomLocationSenderCalled: Bool {
        return didTapAddCustomLocationSenderCallsCount > 0
    }
    var didTapAddCustomLocationSenderReceivedSender: (HomeViewModel)?
    var didTapAddCustomLocationSenderReceivedInvocations: [(HomeViewModel)] = []
    var didTapAddCustomLocationSenderClosure: ((HomeViewModel) -> Void)?

    func didTapAddCustomLocation(sender: HomeViewModel) {
        didTapAddCustomLocationSenderCallsCount += 1
        didTapAddCustomLocationSenderReceivedSender = sender
        didTapAddCustomLocationSenderReceivedInvocations.append(sender)
        didTapAddCustomLocationSenderClosure?(sender)
    }

    //MARK: - didTapLocation

    var didTapLocationLocationSenderCallsCount = 0
    var didTapLocationLocationSenderCalled: Bool {
        return didTapLocationLocationSenderCallsCount > 0
    }
    var didTapLocationLocationSenderReceivedArguments: (location: LocationDomainModel, sender: HomeViewModel)?
    var didTapLocationLocationSenderReceivedInvocations: [(location: LocationDomainModel, sender: HomeViewModel)] = []
    var didTapLocationLocationSenderClosure: ((LocationDomainModel, HomeViewModel) -> Void)?

    func didTapLocation(location: LocationDomainModel, sender: HomeViewModel) {
        didTapLocationLocationSenderCallsCount += 1
        didTapLocationLocationSenderReceivedArguments = (location: location, sender: sender)
        didTapLocationLocationSenderReceivedInvocations.append((location: location, sender: sender))
        didTapLocationLocationSenderClosure?(location, sender)
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
    var createCustomLocationLocationClosure: ((LocationDomainModel) -> Void)?

    func createCustomLocation(location: LocationDomainModel) {
        createCustomLocationLocationCallsCount += 1
        createCustomLocationLocationReceivedLocation = location
        createCustomLocationLocationReceivedInvocations.append(location)
        createCustomLocationLocationClosure?(location)
    }

}
