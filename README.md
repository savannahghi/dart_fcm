# SIL_FCM

SIL_FCM is a wrapper package for setting up and consuming cloud notifications from firebase

### Getting started

Detailed reference - https://pub.dev/packages/firebase_messaging#-readme-tab-

#### Android

- In the Module gradle file, add these dependencies

```
dependencies {
    classpath 'com.android.tools.build:gradle:3.5.3'
    classpath 'com.google.gms:google-services:4.3.2'
}

```

- In the App gradle file, add this at the BOTTOM

```
apply plugin: 'com.google.gms.google-services'

```

- To be notified on application lifecycle callbacks, include the below in the android manifest file

```xml
<intent-filter>
      <action android:name="FLUTTER_NOTIFICATION_CLICK" />
      <category android:name="android.intent.category.DEFAULT" />
  </intent-filter>

  <meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="high_importance_channel" />
```

- Add the lastet version of firebase messaging in app gradle implementations

```
implementation 'com.google.firebase:firebase-messaging:20.1.7'
```

This package uses `Flutter local notifications` to show FCM message. To setup local notifications for 
Android and iOS consult https://pub.dev/packages/flutter_local_notifications#-readme-tab-

