//
//  AutoMockable.swift
//  wikipedia-places-iosTests
//
//  Created by Rizki Calame on 23/08/2024.
//

// sourcery:begin: AutoMockable

// Base Dependencies
extension BaseDependenciesInterface {}
extension WikipediaDeeplinkURLOpenerInterface {}
extension ErrorHandlerInterface {}

// Repositories
extension LocationsRepositoryInterface {}

// UseCases
extension GetLocationsUseCaseInterface {}
extension AddCustomLocationUseCaseInterface {}

// sourcery:end
