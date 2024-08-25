# wikipedia-places-ios

## Introduction

This workspace consists out of two projects:
- `Wikipedia`: forked from the original Wikipedia iOS repository. (https://github.com/wikimedia/wikipedia-ios)
- `wikipedia-places-ios`: an own created Xcode repository that interacts with the Wikipedia app.

The core goal of the `wikipedia-places-ios` application is to showcase the deeplinking capabilities within the `Wikipedia` app. I've adjusted the `Wikipedia` app in a way that the URL scheme also accepts coordinates, which can be used by the app to navigate to the map & show the coordinates passed into the app.

## Getting started

Running this project requires: nothing. The `Wikipedia` app uses Swift Package Manager to manage core dependencies, whereas `wikipedia-places-ios` has no core dependencies, as everything is written vanilla. The only dependency I used is a tool called `Sourcery` (https://github.com/krzysztofzablocki/Sourcery) to help me generate mock testing objects to enhance my unit testing strategy. See the Sourcery section for more details.

Selecting the `wikipedia-places-ios` scheme runs the own created application, whereas the `Wikipedia` scheme runs the original Wikipedia iOS app.

**Showcasing the deeplinking functionality**
Prior to running the `wikipedia-places-ios` app and trying the deeplinkg features out, please run the `Wikipedia` first to ensure the simulator has the adjusted version to allow deeplinking using coordinates. Afterwhich, feel free to run the `wikipedia-places-ios` app and test the functionality out.

1. You are able to use the remotely retrieved data including Amsterdam, Mumbai, Copenhagen and a non-defined location;
2. You also have the possibility to add a custom location using a name (optional), & latlong combination to save the custom location and use that instead.

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

## Sourcery

Sourcery is a powerful tool using Stencil templates to generate Swift files for various purposes. In the context of this project, I used this to generate mock objects based on protocol definitions in the app. The mock objects contain helper methods & properties for me to use during testing to test specific behaviour (e.g. error cases, success cases, etc.) and to determine if the right dependencies were called for a chain of processes to happen.

Emphasis on this is that this is a *helper* tool, meaning it is not necessary to have as a dependency to run the project, since it only generates Swift files and does nothing on compile/run time, which is also the beauty of it: it can help you as an engineer if you have it but doesn't block you from doing anything.

To get started with this in the project:
- I added a Brewfile to collect my brew dependencies;
- Run `brew bundle` to install the necessary dependencies;
- Navigate to the `wikipedia-places-ios` folder (e.g. cd `Projects/wikipedia-places-ios/wikipedia-places-ios`);
- Run `sourcery` in Terminal;

The mock objects are now generated in the Xcode project under: `wikipedia-places-iosTests/Mocks/MockObjects.generated.swift`. Important here is to not adjusted this file manually since this file will be overwritten every time `sourcery` is called. I've added a `MockObjects.manual.swift` file that holds manually written mock objects in case Sourcery doesn't play well with complex classes (e.g. generics etc.).


## Checklist
- [x] Clean Architecture approach
- [x] API client implementation
- [x] Displaying locations
- [x] Custom locations
- [x] Deeplinking into the Wikipedia app
- [x] Unit tests
- [x] Accessibility
- [] (Sample) UI tests - alas ran out of time to cover this, but we can always discuss during the technical.
- [x] Sourcery

## Who to talk to
- Rizki Calame - rtj.calame@gmail.com
