README: About Firebase Files

This project excludes the following Firebase-related files from version control for security reasons:

firebase_options.dart

google-services.json

GoogleService-Info.plist

Why Are These Files Missing From the Project?

These files contain authentication and configuration information for the Firebase project. To ensure the security of sensitive data, these files have not been uploaded to the repository. This precaution is taken to safeguard the project and protect Firebase resources from unauthorized access.

Adding Firebase Configuration Files

To run this project, you need to manually add these Firebase files to the project directory. Follow the steps below to include the missing files:

1. firebase_options.dart

This file can be automatically generated using the Firebase CLI or FlutterFire CLI.

Use the following command in the terminal to create the file:

flutterfire configure

This command configures the Firebase project and generates the firebase_options.dart file to include in your project.

2. google-services.json (Android)

Go to Firebase Console > Project Settings > General > Your Apps.

Select your Android app and click "Download google-services.json" to download the file.

Add this file to the android/app directory in your project.

3. GoogleService-Info.plist (iOS)

Go to Firebase Console > Project Settings > General > Your Apps.

Select your iOS app and click "Download GoogleService-Info.plist" to download the file.

Add this file to the ios/Runner directory in your project.

Security Recommendations

Never upload sensitive files to a public repository.

Add firebase_options.dart, google-services.json, and GoogleService-Info.plist to your .gitignore file to exclude them from version control.

lib/firebase_options.dart
android/app/google-services.json
ios/Runner/GoogleService-Info.plist

Support

If you need help obtaining these files or integrating Firebase with your project, you can refer to the Firebase documentation or contact me for assistance.

Firebase Documentation: https://firebase.google.com/docs

