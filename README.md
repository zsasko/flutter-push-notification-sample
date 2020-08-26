# Flutter Push Notification Sample

This project is sample application that demonstrates receiving FCM push notification in Flutter Android App sent from NodeJS backend.

![](https://cdn-images-1.medium.com/max/800/1*bu2DFL_fQ2pEKs8sEIldTA.png)

It's a source code for the following article on the medium:

- https://medium.com/@zoransasko/sending-push-notifications-from-nodejs-backend-to-flutter-android-app-8a261c3c2c61

In order to start this sample, please make sure that you've created FCM Android App with the following package name: 
```
com.example.push_notification_flutter_sample
```
and added 'google-services.json' into 'android/app' folder.

In order to fetch Flutter dependencies, please execute the following script:
```
flutter pub get
```
And run the app in emulator by executing the following script:
```
flutter build apk
flutter install
```
