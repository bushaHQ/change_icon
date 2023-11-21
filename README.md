# changeicon

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Change Icon

![Change Icon](https://github.com/bushaHQ/change_icon/assets/36260221/f7116c51-5d60-451c-bcd7-1292e265f1bb)

![GitHub](https://img.shields.io/github/license/bushaHQ/change_icon?style=plastic) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/bushaHQ/change_icon?style=plastic) ![GitHub top language](https://img.shields.io/github/languages/top/bushaHQ/change_icon?style=plastic) ![GitHub language count](https://img.shields.io/github/languages/count/bushaHQ/change_icon?style=plastic) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/bushaHQ/change_icon?style=plastic) ![GitHub issues](https://img.shields.io/github/issues/bushaHQ/change_icon?style=plastic) 

![GitHub Repo stars](https://img.shields.io/github/stars/bushaHQ/change_icon?style=social) ![GitHub forks](https://img.shields.io/github/forks/bushaHQ/change_icon?style=social)

##  Compatibility

✅ &nbsp; Android </br>
✅ &nbsp; iOS

## Features

All the features listed below can be performed at the runtime.

✅ &nbsp; Change App Icons </br>
✅ &nbsp; Change App Label </br>

Features only work for IOS for now

✅ &nbsp

<!-- ## Demo -->

<!-- |<img height=500 src="https://i.imgur.com/UPcyPEl.gif"/>|
|---| -->

## Android Setup

### Step 1: Include plugin to your project

```yml
dependencies:
  changeicon: <latest version>
```

### Step 2: Add activity-alias in AndroidManifest.xml

```xml
...
...
<application
    android:label="changeicon_example"
    android:icon="@mipmap/ic_launcher">
    <activity
        android:name=".MainActivity"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize">
        <meta-data
            android:name="io.flutter.embedding.android.NormalTheme"
            android:resource="@style/NormalTheme"
            />
        <meta-data
            android:name="io.flutter.embedding.android.SplashScreenDrawable"
            android:resource="@drawable/launch_background"
            />
        <intent-filter>
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>

    <!-- Live Icon Addition -->
    <activity-alias
        android:name=".DarkTheme"
        android:enabled="false"
        android:icon="@mipmap/dark_theme"
        android:label="DarkThemeLabel"
        android:targetActivity=".MainActivity">
        <intent-filter>
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity-alias>

    <activity-alias
        android:name=".LightTheme"
        android:enabled="false"
        android:icon="@mipmap/light_theme"
        android:label="LightThemeLabel"
        android:targetActivity=".MainActivity">
        <intent-filter>
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity-alias>
    <!-- Live Icon Addition -->

    <meta-data
        android:name="flutterEmbedding"
        android:value="2" />

</application>
...
...
```

### Step 3: Create classes

Create java/kotlin files with the same name as provided in activity-alias.

In the above AndroidManifest.xml example, 2 activity-alias are provided, so the number of java/kotlin files will be 2.
Example:

#### 1. `DarkTheme.java`

```java
package com.example.changeicon_example;

public class DarkTheme {
}
```

#### 2. `LightTheme.java`

```java
package com.example.changeicon_example;

public class LightTheme {
}
```

One thing to note here is that, we have added two extra activity as activity-alias, and we now have 3 activity in total.

### Step 4: Initialise plugin

List all the activity-alias class names. 
**NOTE:** `MainActivity` will also be added here as it containes the launch intent.

```dart
Changeicon.initialize(
    classNames: ['MainActivity', 'DarkTheme', 'LightTheme'],
);
```

### Step 5: Switch App icon

Use `switchIconTo` to switch app icons. It takes in the className that must match the desired activity-alias `android:name`.

```dart
await _changeiconPlugin.switchIconTo(
    className: 'DarkTheme',
);
```