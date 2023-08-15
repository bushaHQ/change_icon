import 'bushaicon_platform_interface.dart';

class Bushaicon {
  Future<String?> getPlatformVersion() {
    return BushaiconPlatform.instance.getPlatformVersion();
  }

  Future<void> switchIconTo({required String className}) async {
    await BushaiconPlatform.instance.switchIconTo(className: className);
  }

  static Future<void> initialize({required List<String> classNames}) async {
    await BushaiconPlatform.instance.initialize(classNames: classNames);
  }

  /// Indicates whether the current platform supports dynamic app icons
  static Future<bool> get supportsAlternateIcons async {
    final bool supportsAltIcons = await BushaiconPlatform.instance.supportsAlternateIcons();
    return supportsAltIcons;
  }

  /// Fetches the current iconName
  ///
  /// Returns `null` if the current icon is the default icon
  static Future<String?> getAlternateIconName() async {
    final String? altIconName = await BushaiconPlatform.instance.getAlternateIconName();
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
  static Future setAlternateIconName(String? iconName, {bool showAlert = true}) async {
    await BushaiconPlatform.instance.setAlternateIconName(iconName, showAlert: showAlert);
  }

  /// Fetches the icon batch number
  ///
  /// The default value of this property is `0` (to show no batch)
  static Future<int> getApplicationIconBadgeNumber() async {
    final int batchIconNumber = await BushaiconPlatform.instance.getApplicationIconBadgeNumber();
    return batchIconNumber;
  }

  /// Sets [batchIconNumber] as the batch number for the current icon for the app
  ///
  /// Set to 0 (zero) to hide the badge number.
  ///
  /// Throws a [PlatformException] in case an error
  static Future setApplicationIconBadgeNumber(int batchIconNumber) async {
    await BushaiconPlatform.instance.setApplicationIconBadgeNumber(batchIconNumber);
  }
}
