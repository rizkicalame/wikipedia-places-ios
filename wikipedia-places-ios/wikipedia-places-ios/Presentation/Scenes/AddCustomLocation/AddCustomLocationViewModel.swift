//
//  AddCustomLocationViewModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

final class AddCustomLocationViewModel: ObservableObject {

    // MARK: - State

    enum State: Equatable {
        case unknownError
        case error(AddCustomLocationUseCase.ValidationErrors)
        case idle
    }

    // MARK: - Published variables

    @Published var nameOfLocation: String = ""
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var state: State = .idle

    // MARK: - Computed

    var errorText: String {
        switch state {
        case .unknownError:
            return "An unknown error has occurred."
        case .error(let validationErrors):
            switch validationErrors {
            case .invalidLatitudeProvided: return "Please provide a valid latitude."
            case .invalidLongitudeProvided: return "Please provide a valid longitude."
            }
        case .idle:
            return ""
        }
    }

    var shouldDisplayErrorMessage: Bool {
        return state != .idle
    }

    // MARK: - Properties

    private let useCase: AddCustomLocationUseCaseInterface

    weak var delegate: AddCustomLocationViewModelDelegate?

    // MARK: - Init

    init(useCase: AddCustomLocationUseCaseInterface) {
        self.useCase = useCase
    }

    // MARK: - Internal

    func onSubmitTapped() {
        addCustomLocation()
    }

    // MARK: - Private

    private func addCustomLocation() {
        do {
            try useCase.addCustomLocation(name: nameOfLocation,
                                      latitude: latitude,
                                      longitude: longitude)
            self.delegate?.didAddCustomLocation(sender: self)
        } catch {
            guard let error = error as? AddCustomLocationUseCase.ValidationErrors else {
                return state = .unknownError
            }

            state = .error(error)
        }
    }
}

// MARK: Localization
/// Localization extension so that the ViewModel can hold texts and becomes testable.
extension AddCustomLocationViewModel {
    
    var locationFormTitle: String {
        "Name of location"
    }

    var locationPlaceholder: String {
        "E.g. Amsterdam"
    }

    var latitudeFormTitle: String {
        "Latitude"
    }

    var latitudePlaceholder: String {
        "52.0000"
    }

    var longitudeFormTitle: String {
        "Longitude"
    }

    var longitudePlaceholder: String {
        "14.0000"
    }

    var submitButtonTitle: String {
        "Submit"
    }

    var navigationTitle: String {
        "Add custom location"
    }
}
