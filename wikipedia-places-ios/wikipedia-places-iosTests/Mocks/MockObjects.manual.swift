//
//  MockObjects.manual.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 25/08/2024.
//

import Foundation

@testable import wikipedia_places_ios

class APIClientInterfaceMock<T: Decodable>: APIClientInterface {
    //MARK: - performRequest<DataModel: Decodable>

    var performRequestPathMethodKeyPathThrowableError: Error?
    var performRequestPathMethodKeyPathCallsCount = 0
    var performRequestPathMethodKeyPathCalled: Bool {
        return performRequestPathMethodKeyPathCallsCount > 0
    }
    var performRequestPathMethodKeyPathReceivedArguments: (path: String, method: HTTPMethod, keyPath: String?)?
    var performRequestPathMethodKeyPathReceivedInvocations: [(path: String, method: HTTPMethod, keyPath: String?)] = []
    var performRequestPathMethodKeyPathReturnValue: T!
    var performRequestPathMethodKeyPathClosure: ((String, HTTPMethod, String?) async throws -> T)?

    func performRequest<DataModel: Decodable>(path: String, method: HTTPMethod, keyPath: String?) async throws -> DataModel {
        performRequestPathMethodKeyPathCallsCount += 1
        performRequestPathMethodKeyPathReceivedArguments = (path: path, method: method, keyPath: keyPath)
        performRequestPathMethodKeyPathReceivedInvocations.append((path: path, method: method, keyPath: keyPath))
        if let error = performRequestPathMethodKeyPathThrowableError {
            throw error
        }
        if let performRequestPathMethodKeyPathClosure = performRequestPathMethodKeyPathClosure {
            return try await performRequestPathMethodKeyPathClosure(path, method, keyPath) as! DataModel
        } else {
            return performRequestPathMethodKeyPathReturnValue as! DataModel
        }
    }
}

actor CustomLocationsCacheInterfaceMock: CustomLocationsCacheInterface {




    //MARK: - getCustomLocations

    var getCustomLocationsCallsCount = 0
    var getCustomLocationsCalled: Bool {
        return getCustomLocationsCallsCount > 0
    }
    var getCustomLocationsReturnValue: [LocationDataModel]!
    var getCustomLocationsClosure: (() -> [LocationDataModel])?

    func getCustomLocations() -> [LocationDataModel] {
        getCustomLocationsCallsCount += 1
        if let getCustomLocationsClosure = getCustomLocationsClosure {
            return getCustomLocationsClosure()
        } else {
            return getCustomLocationsReturnValue
        }
    }

    //MARK: - addLocations

    var addLocationsCallsCount = 0
    var addLocationsCalled: Bool {
        return addLocationsCallsCount > 0
    }
    var addLocationsReceivedLocations: ([LocationDataModel])?
    var addLocationsReceivedInvocations: [([LocationDataModel])] = []
    var addLocationsClosure: (([LocationDataModel]) -> Void)?

    func addLocations(_ locations: [LocationDataModel]) {
        addLocationsCallsCount += 1
        addLocationsReceivedLocations = locations
        addLocationsReceivedInvocations.append(locations)
        addLocationsClosure?(locations)
    }

    //MARK: - clearCache

    var clearCacheCallsCount = 0
    var clearCacheCalled: Bool {
        return clearCacheCallsCount > 0
    }
    var clearCacheClosure: (() -> Void)?

    func clearCache() {
        clearCacheCallsCount += 1
        clearCacheClosure?()
    }

}
