#  CSTV

![Swift](https://img.shields.io/badge/Swift-5-orange)
![iOS](https://img.shields.io/badge/iOS-17.2%2B-blue)
![Status](https://img.shields.io/badge/status-developing-yellow)
![build](https://img.shields.io/badge/build-passing-green)

## Descrição

This is an app that display Counter Strike matches happening accross several worldwide tournaments. It shows a list with matches beginning in the current localized date. It also has a details screen that shows team names, images, roster and match time.

## Features

- List of matches
- Details of a match

## Technologies

- **Swift** - Programming language
- **SwiftUI** - User interface framework
- **Combine** - Reactive API calls
- **Coordinator** - Navigation framework
- **Dependency Injection** - Harmless class dependencies resolutions
- **Clean Architecture** - Folders and code organization

PS. Even though clean-architecture's domain layer is the most important, it has been suppressed from this project for the sake of simplicity. Fetching and caching responsability has been left to repositories (on data layer). While data manipulation like conversions and sorting has been done on view-models (presentation layer). MVVM is the presentation layer pattern adopted.

## Requirements

- **XCode** 15+
- **Swift** 5+

## Dependencies

- [Resolver](https://github.com/hmlongco/Resolver)

## Installation

1. Clone repository
```bash
git clone https://github.com/viniciusromani/cstv-fuzecc.git
```

2. Open file `cstv-fuzecc.xcodeproj`

3. The dependencies will be automatically resolved with SPM but you can check them on the `Package Dependencies`

4. Set build target and simulator preference and run the application

## Usage

1. After installing and launching, you will se a list of Counter Strike matches on the main screen.

2. Swipping up will refresh list any time.

3. Scrolling down will allow you to see all matches happening on the current date.

4. Clicking on cards will navigate you to details screen where you can see match details and teams **active** players (it does mean that all players have played that match, it is only a list of active player of that team).

5. Details screen also shows League and Serie information of that match.

## Tests

This project has unit tests for the main features and files. It does not have UI-Tests though. To run tests:

1. Navigate to Test navigator

2. Run them all on start button next to the target's name (cstv-fuzeccTests)

## Contributing

Contributions are always welcome. Make to sure to follow the steps to contribute:

1. Fork project

2. Create your feature branch
```bash
git checkout -b feature/<your-branch>
```

3. Code, commit and push

4. Open a pull request and describe what you did on description field

## TODO

- Create Resolver container to solve dependencies for test target

- Improve cache layer by using User Default or CoreData to keep it cached even if the user closes app. Specify time to live for the end of each day. Always fetch to compare cached x fetched values to decide whether to save on cache. If there is cache, show it and then updated it if needed (fetched values are different from cached)

- Improve unit test by testing MatchDetailsViewModel

- Use Previews to test interface

- Store Match Object status in an enum

**Important**: Pagination was a spec but I decided not to implement since there is sorting on list. For pagination to work, it should have come sorted from backend

## License

Distributed under [MIT license](License.md)
