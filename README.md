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

✅ &nbsp; Set Batch Number

## Demo

| IOS  | Android |
| ------------- | ------------- |
| <img src="https://github.com/bushaHQ/change_icon/assets/36260221/f434aeb8-6e6e-4350-9488-82d34e203bbe" width="200" height="390"> | <img src="https://github.com/bushaHQ/change_icon/assets/36260221/d7ccfa64-0e6e-478a-a758-60e3b0def3b2" width="200" height="390">  |


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

## IOS Setup

### Step 1: Include plugin to your project

```yml
dependencies:
  changeicon: <latest version>
```


### Step 2: Include your icons to the project

#### Index
* `2x` - `120px x 120px`  
* `3x` - `180px x 180px`

To integrate your plugin into the iOS part of your app, follow these steps

1. First let us put a few images for app icons, they are 
    * `teamfortress@2x.png`, `teamfortress@3x.png` 
    * `photos@2x.png`, `photos@3x.png`, 
    * `chills@2x.png`, `chills@3x.png`,
2. These icons shouldn't be kept in `Assets.xcassets` folder, but outside. When copying to Xcode, you can select 'create folder references' or 'create groups'.

Example: </br>

<img width="250" alt="Screenshot 2023-11-21 at 10 18 12" src="https://github.com/bushaHQ/change_icon/assets/36260221/cacfbec1-f38e-4b91-abfd-27bb637f75d9">

</br>

3. Next, we need to setup the `Info.plist`
    1. Add `Icon files (iOS 5)` to the Information Property List
    2. Add `CFBundleAlternateIcons` as a dictionary, it is used for alternative icons
    3. Set 3 dictionaries under `CFBundleAlternateIcons`, they are correspond to `teamfortress`, `photos`, and `chills`
    4. For each dictionary, two properties — `UIPrerenderedIcon` and `CFBundleIconFiles` need to be configured
	5. If the sub-property `UINewsstandIcon` is showing under `Icon files (iOS 5)` and you don't plan on using it (it is intended for use with Newstand features), erase it or the app will get rejected upon submission on the App Store


Note that if you need it work for iPads, You need to add these icon declarations in `CFBundleIcons~ipad` as well. [See here](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/TP40009249-SW14) for more details.

Example: </br>

#### Raw
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIcons</key>
	<dict>
		<key>CFBundleAlternateIcons</key>
		<dict>
			<key>chills</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>chills</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>photos</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>photos</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>teamfortress</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>teamfortress</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
		</dict>
		<key>CFBundlePrimaryIcon</key>
		<dict>
			<key>CFBundleIconFiles</key>
			<array>
				<string>chills</string>
			</array>
			<key>UIPrerenderedIcon</key>
			<false/>
		</dict>
	</dict>
...
...
</dict>
</plist>

```

### Dart/Flutter Integration

From your Dart code, you need to import the plugin and use it's static methods:

```dart 
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

try {
  if (await FlutterDynamicIcon.supportsAlternateIcons) {
    await FlutterDynamicIcon.setAlternateIconName("photos");
    print("App icon change successful");
    return;
  }
} on PlatformException {} catch (e) {}
print("Failed to change app icon");

...

// set batch number
try {
	await FlutterDynamicIcon.setApplicationIconBadgeNumber(9399);
} on PlatformException {} catch (e) {}

// gets currently set batch number
int batchNumber = FlutterDynamicIcon.getApplicationIconBadgeNumber();

```