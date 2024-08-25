# wikipedia-places-ios

## Introduction

This workspace consists out of two projects:
- `Wikipedia`: forked from the original Wikipedia iOS repository. (https://github.com/wikimedia/wikipedia-ios)
- `wikipedia-places-ios`: an own created Xcode repository that interacts with the Wikipedia app.

The core goal of the `wikipedia-places-ios` application is to showcase the deeplinking capabilities within the `Wikipedia` app. I've adjusted the `Wikipedia` app in a way that the URL scheme also accepts coordinates, which can be used by the app to navigate to the map & show the coordinates passed into the app.

## Getting started

Running this project requires: nothing. The `Wikipedia` app uses Swift Package Manager to manage core dependencies, whereas `wikipedia-places-ios` has no core dependencies, as everything is written vanilla.

Selecting the `wikipedia-places-ios` scheme runs the own created application, whereas the `Wikipedia` scheme runs the original Wikipedia iOS app.

## Architecture

I chose for an adaption of Clean Architecture for the `wikipedia-places-ios` app. Having used Clean Swift broadly in the past, I've experienced this type of architecture to keep the codebase decoupled, maintable and more importantly: testable. The following core components are made for this project:

- Presentation:
    - View: The pure UI layer containing code responsible for displaying elements to the user. Written in SwiftUI.
    - ViewModel: The object containing view related logic, in charge of communicating to UseCases to fetch data necessary to present data to the user.
- Business:
    - UseCases: The UseCase is at the core of the business logic, where calls to repositories are initiated and business logic related processes are run. 
    - DomainModel: The DomainModel is the model mostly used within the domain (e.g. the app). This model is a reflection of the data model, stripped of any unnecessary data.
- Data:
    - Repository: The repository is the object in charge of retrieving data (either locally or remotely).
    - DataModel: The DataModel is the model that flows into the application from data sources. The DataModel is transformed into the DomainModel, where unnecessary data is stripped from the model.
    
Furthermore I'm a big supporter of "composition over inheritance" and to enforce this, most of the core objects stated above have been put behind a protocol definition. This way, it makes it easier for test components individually for behaviour, where we are able to mock dependencies of components.

## Running the project

## Checklist
- [x] Clean Architecture approach
- [x] API client implementation
- [x] Displaying locations
- [x] Custom locations
- [x] Deeplinking into the Wikipedia app
- [x] Unit tests
- [] Accessibility
- [] (Sample) UI tests
- [x] Sourcery

## Who to talk to
- Rizki Calame
