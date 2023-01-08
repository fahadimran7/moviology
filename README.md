# Moviology

> My first Flutter app for discovering movies and TV shows using the [IMDb API](https://developer.imdb.com/) and Firebase.

![](./upload/banner.png)

## Features

As per the requirements for my Mobile Application Development for SMEs (EC303) course, I implemented the following features:

- [x] External API for data
- [x] State management
- [x] Audio and sounds
- [x] Push notifications using Firebase
- [x] Firebase authentication
- [x] Firestore db
- [x] Firebase cloud storage
- [x] Secure storage

## API Key

The app uses movies data from the [IMDb API](https://imdb-api.com/). The free account provides you with an API Key limited to 100 requests per day.
To configure environment variables in flutter, create a `.env` file in the root of the project and add the following value to it:

```
IMDB_API_KEY=<YOUR_API_KEY>
```

## Usage

```bash
# clone the repo
$ git clone https://github.com/fahadimran7/moviology.git
$ cd moviology

# install dependencies
$ flutter pub get

# run the app
$ flutter run
```

## Screenshots

For app screenshots, see the [upload](https://github.com/fahadimran11/moviology/tree/master/upload) folder 🚀

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
