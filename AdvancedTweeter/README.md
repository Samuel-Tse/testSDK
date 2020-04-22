
# Personal's iOS Testing Project 

## Getting Started
This Project is an app that simulates Twitter tweet a message and process with the message.

- Written in Swift
- Only support for iPhone
- Support iOS version 11.0 and above

## Purpose
This project is for testing Sentry and Dynatrace SDKs.

### App Functionality

- The app has a splash screen as the welcome animation 

- The app can login with only username (as real login function is not implemented)

- But after user logs in, the user name will be displayed

- User can tweet a new message according to the requirements

- App has a GET method and a PUT method, using URLSession

### App Structure

- Code is written in MVVM design pattern
- Seperated api services to Service folder
- Placed some functions in Extension

### Notes

- App may have bugs, Internet Checking is not implemented yet due to time constraint 
- App may need furthur optimization
- User Avatar is not implemented
- GET method will get all the contents from database, furthur improvement can be done by "pull to refresh" to pull some amount of data every time

## Backend

- Backend api functions are written in PHP
- Server is using my friend's personal server (HostGator)
- DB is using MySQL

## License
This project is under MIT LICENSE
