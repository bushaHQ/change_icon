import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bushaicon_platform_interface.dart';

/// An implementation of [BushaiconPlatform] that uses method channels.
class MethodChannelBushaicon extends BushaiconPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bushaicon');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> switchIconTo({required String className}) async {
    await methodChannel.invokeMethod("switchIconTo", [className]);
  }

  @override
  Future<void> initialize({required List<String> classNames}) async {
    await methodChannel.invokeMethod("initialize", classNames);
  }

  /// Indicates whether the current platform supports dynamic app icons
  @override
  Future<bool> supportsAlternateIcons() async {
    final bool supportsAltIcons = await methodChannel.invokeMethod('mSupportsAlternateIcons');
    return supportsAltIcons;
  }

  /// Fetches the current iconName
  ///
  /// Returns `null` if the current icon is the default icon
  @override
  Future<String?> getAlternateIconName() async {
    final String? altIconName = await methodChannel.invokeMethod('mGetAlternateIconName');
    return altIconName;
  }

  /// Sets [iconName] as the current icon for the app
  ///
  /// [iOS]: Use [showAlert] at your own risk as it uses a private/undocumented API to
  /// not show the icon change alert. By default, it shows the alert
  /// Reference: https://stackoverflow.com/questions/43356570/alternate-icon-in-ios-10-3-avoid-notification-dialog-for-icon-change/49730130#49730130
  ///
  /// Throws a [PlatformException] with description if
  /// it can't find [iconName] or there's any other error
  @override
  Future setAlternateIconName(String? iconName, {bool showAlert = true}) async {
    await methodChannel.invokeMethod(
      'mSetAlternateIconName',
      <String, dynamic>{
        'iconName': iconName,
        'showAlert': showAlert,
      },
    );
  }

  /// Fetches the icon batch number
  ///
  /// The default value of this property is `0` (to show no batch)
  @override
  Future<int> getApplicationIconBadgeNumber() async {
    final int batchIconNumber = await methodChannel.invokeMethod('mGetApplicationIconBadgeNumber');
    return batchIconNumber;
  }

  /// Sets [batchIconNumber] as the batch number for the current icon for the app
  ///
  /// Set to 0 (zero) to hide the badge number.
  ///
  /// Throws a [PlatformException] in case an error
  @override
  Future setApplicationIconBadgeNumber(int batchIconNumber) async {
    await methodChannel.invokeMethod(
        'mSetApplicationIconBadgeNumber', <String, Object>{'batchIconNumber': batchIconNumber});
  }
}
