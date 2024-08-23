//
//  AddCustomLocationView.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import SwiftUI

protocol AddCustomLocationViewModelDelegate: AnyObject {
    func didAddCustomLocation(sender: AddCustomLocationViewModel)
}

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

struct AddCustomLocationView: View {
    @ObservedObject var viewModel: AddCustomLocationViewModel

    var body: some View {

        Form {
            Section {
                FormInputLabel(title: "Name of location")
                FormInputField(placeholder: "E.g. Amsterdam", 
                               textBinding: $viewModel.nameOfLocation)

                FormInputLabel(title: "Latitude *")
                FormInputField(placeholder: "52.00000",
                               textBinding: $viewModel.latitude)


                FormInputLabel(title: "Longitude *")
                FormInputField(placeholder: "14.00000",
                               textBinding: $viewModel.longitude)
            }

            Section {
                Button {
                    viewModel.onSubmitTapped()
                } label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Add custom location")
    }
}
