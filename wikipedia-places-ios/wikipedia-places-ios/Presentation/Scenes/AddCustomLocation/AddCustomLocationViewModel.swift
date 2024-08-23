//
//  AddCustomLocationViewModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

final class AddCustomLocationViewModel: ObservableObject {

    // MARK: - Published variables

    @Published var nameOfLocation: String = ""
    @Published var latitude: String = ""
    @Published var longitude: String = ""

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
        useCase.addCustomLocation(name: nameOfLocation,
                                  latitude: latitude,
                                  longitude: longitude)
        self.delegate?.didAddCustomLocation(sender: self)
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
