# Pinterest Clone App

A Pinterest-inspired mobile application built with Flutter as part of an assignment project. The goal of this project was to recreate the feel of the Pinterest mobile app.

## Project Overview

This application is a Pinterest-style clone that implements the core user-facing flows of the mobile app, including:

- authentication flow
- home feed with masonry layout
- search experience with featured sections and collage rows
- pin detail page
- saved section with pins, boards, and collages tabs
- inbox screen
- profile and account related screens
- persistent login session
- responsive UI adjustments for different Android and iPhone screen sizes

The application was developed to satisfy assignment expectations around:

- UI resemblance
- architecture
- code quality
- responsiveness
- performance-aware image loading

## Features Implemented

### 1. Authentication Flow
The app includes a multi-step authentication flow inspired by the Pinterest onboarding experience.

Implemented screens and behavior:
- splash / loader sequence
- email entry screen
- login screen
- create password screen
- create name screen
- session persistence
- logout flow

Authentication logic uses Clerk and local email(using shared Preferences's) existence lookup handling for route branching between login and signup.

### 2. Home Feed
The home screen is designed around a Pinterest-style feed.

Implemented behavior:
- staggered masonry layout using `flutter_staggered_grid_view`
- remote image loading from API
- shimmer placeholders while content loads
- pull-to-refresh style top loader
- infinite scroll / load-more trigger
- fixed top header area
- tap on a pin opens the pin detail screen

### 3. Pin Detail Page
The pin detail page is connected to the selected item from the home feed.

Implemented behavior:
- opens with slide transition
- displays the same selected image from the home feed
- dynamic title and creator information based on item data
- related pins section
- Pinterest-style action row and save button UI

### 4. Search Screen
The search page reproduces Pinterest-inspired discovery behavior.

Implemented behavior:
- fixed top search bar
- hero banner section with page view
- page indicator dots
- ideas card section
- collage-style topic sections
- remote images loaded from API
- shimmer loading screen

### 5. Saved Section
The saved area includes a tab-based layout similar to Pinterest profile saving views.

Implemented tabs:
- Pins
- Boards
- Collages

Implemented behavior:
- shared header
- dynamic profile initial from logged-in user name
- navigation to edit profile
- navigation to your account screen
- empty-state illustrations and actions

### 6. Inbox Screen
The inbox screen includes:
- inbox header
- message section
- invite friends tile
- updates section
- no-updates empty state

### 7. Edit Profile and Account Screens
The account-related screens include:
- edit profile page
- account screen
- profile initial from authenticated user data
- account options UI
- logout option at your account screen

### 8. Responsive Design
A reusable responsive utility was introduced so the layouts adapt better across:
- Android phones
- compact screens
- taller screens
- iPhone-sized screens

Responsive handling was applied to:
- paddings
- spacing
- icon sizes
- border radii
- text sizes
- component heights and widths

## Tech Stack

### Framework
- Flutter
- Dart

### State Management
- `flutter_riverpod`

### Navigation
- `go_router`
- for some cases `Navigator.push()`

### Authentication
- `clerk_flutter`

### Networking
- `dio`

### Image Loading and Caching
- `cached_network_image`

### Grid / Pinterest Layout
- `flutter_staggered_grid_view`

### Loading Placeholders
- `shimmer`

## API Used

Image-based content is fetched using the **Pexels API**.

Used for:
- home feed content
- search page featured banners
- search page cards and collage sections
- pin detail page

## Project Architecture

The codebase follows a structured Flutter approach with separation between:
- config
- features
- routes
- screens
- utils
- widgets

Main architectural ideas used:
- Riverpod providers for app state
- repository pattern for remote data fetching
- reusable widgets for repeated UI components
- centralized routes and custom transitions
- auth state driven navigation decisions

## Main Screens Built

The project includes the following major screens:
- Loader Screen
- Email Entry Screen
- Login Screen
- Create Password Screen
- Create Name Screen
- Home Screen
- Search Screen
- Pin Detail Screen
- Saved Screen
- Edit Profile Screen
- Account Screen
- Inbox Screen
- Create Screen placeholder
- Personalized placeholder flow support

## Dependencies

Add these dependencies in `pubspec.yaml` if they are not already present:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_native_splash: ^2.4.7
  flutter_riverpod: ^2.6.1
  go_router: ^14.8.1
  clerk_flutter: ^0.0.14-beta
  clerk_auth: ^0.0.14-beta
  path_provider: ^2.1.5
  shared_preferences: ^2.3.2
  dio: ^5.7.0
  cached_network_image: ^3.4.1
  shimmer: ^3.0.0
  flutter_staggered_grid_view: ^0.7.0
  flutter_launcher_icons: ^0.14.4
```


## Responsive Utility

A custom responsive utility was used to scale UI values in a controlled way.

Examples of responsive adjustments:
- `AppResponsive.w(...)`
- `AppResponsive.h(...)`
- `AppResponsive.r(...)`
- `AppResponsive.sp(...)`

This helped maintain a similar visual design while fitting multiple screen sizes.

## Performance Considerations

The project includes several decisions to improve performance and perceived smoothness:
- cached image loading
- shimmer placeholders while waiting for network images
- paginated image feed loading
- masonry layout for efficient Pinterest-like rendering
- minimized unnecessary rebuilds through structured state handling
- fixed headers in key screens where appropriate

## Use of AI in Development

AI assistance was used as a development support tool during this project.

AI was used for:
- UI structuring suggestions
- Flutter widget composition guidance
- route and state management refinement
- improving responsive design conversions
- generating boilerplate code faster
- debugging and restructuring selected parts of the app

However, the following still remained part of the actual project-building work:
- understanding the assignment requirements
- deciding app flow and screen priority
- integrating features into one connected application
- testing layouts and navigation behavior
- adjusting UI manually to match the required look
- selecting and refining the code
- selecting and refining what should remain in the final implementation

So AI was used as a productivity and assistance tool, not as a replacement for implementation decisions, integration, or project understanding.

## What Was Built for Assignment Evaluation

This project was prepared keeping common assignment evaluation factors in mind.

### UI / UX
- Pinterest-inspired layouts
- image-driven screen design
- bottom navigation flow
- empty states and loading states
- visual consistency across screens

### Code Quality
- split into screens, widgets, models, and state layers
- reusable components
- clear dependency usage
- consistent Flutter structure

### Architecture
- Riverpod for state management
- GoRouter for route flow
- repository-based network handling
- custom transitions and reusable helpers

### Responsiveness
- responsive utility-based scaling
- screen-by-screen widget adaptation
- layout preservation across different device sizes

## Limitations / Incomplete Areas

This project is strong as an assignment submission, but a few areas are still lighter than a production app:
- the Create screen is currently a placeholder
- some saved/inbox/account actions are UI-level only
- full save-to-board logic is limited
- some sections are designed as empty states rather than fully dynamic content systems

These limitations were accepted based on assignment scope and time prioritization, while keeping the major Pinterest-like flows functional and visually representative.

## How to Run

1. Clone the repository
2. Run `flutter pub get`
3. Configure required API keys:
    - Pexels API key
    - Clerk configuration
4. Run the app:

```bash
flutter run
```

## Conclusion

This project is a Pinterest-inspired Flutter mobile app built for assignment evaluation with focus on:
- UI similarity
- responsive behavior
- architecture
- authentication flow
- image-rich Pinterest-style feed and discovery screens

It demonstrates practical Flutter development using modern libraries and a structured approach to building a multi-screen mobile application.