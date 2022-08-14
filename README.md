# Moviology | Flutter, Firebase, IMDb

> Explore your favourite TV shows and movies - an app built using Flutter, Firebase and IMDb API.

## Tech Used

- Flutter
- Firebase
- IMDb API
- GitHub

## Features

As per the requirements for my Mobile Application Development for SMEs (EC303) course, I implemented the following features:

- [x] External API i.e. IMDb API
- [x] Provider for state management
- [x] Audio and sounds
- [x] Push notifications using Firebase
- [x] Firebase authentication
- [x] Firestore database
- [x] Firebase cloud storage
- [x] Secure storage

## Screenshots

To view app and Firebase screenshots visit the following [Google drive link]() 🚀

## API Key

The app uses movies data from the [IMDb API](https://imdb-api.com/). The free account provides you with an API Key limited to 100 requests per day.
To configure environment variables in flutter, create a `.env` file in the root of the project and add the following value to it:

```
IMDB_API_KEY=<YOUR_API_KEY>
```

## Usage

Clone the repository locally:

```
$ git clone https://github.com/fahadimran7/flutter_movie_finder_app.git
$ cd flutter_movie_finder_app
```

Install dependencies:

```
$ flutter pub get
```

Run the app:

```
$ flutter run lib/main.dart
```

## Learnings

By building this project, I learned the following concepts:

- Using Flutter layout widgets for building UI components
- Stateful and Stateless widgets
- Provider for state management
- Asynchronous programming (fetching data from external API)
- Parsing JSON data
- Firebase authentication
- Firebase firestore for storing user profiles
- Firebase cloud storage for profile images
- Storing data offline using secure storage

## Improvements

Implementing MVVM (Model-View-ViewModel) architecture and creating independent services for things like authentication, storage etc. can help to make the app more scalable. I could also consider refactoring the code to use Streams and Stream builders for handling real-time data from Firebase.

## Contributions

The repository has been archived because I do not plan to update the project.
