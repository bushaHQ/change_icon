import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'changeicon_method_channel.dart';

abstract class ChangeiconPlatform extends PlatformInterface {
  /// Constructs a ChangeiconPlatform.
  ChangeiconPlatform() : super(token: _token);

  static final Object _token = Object();

  static ChangeiconPlatform _instance = MethodChannelChangeicon();

  /// The default instance of [ChangeiconPlatform] to use.
  ///
  /// Defaults to [MethodChannelChangeicon].
  static ChangeiconPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ChangeiconPlatform] when
  /// they register themselves.
  static set instance(ChangeiconPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> switchIconTo({required List<String> classNames}) {
    throw UnimplementedError('switchIconTo() has not been implemented.');
  }

  Future<void> initialize({required List<String> classNames}) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Indicates whether the current platform supports dynamic app icons
  Future<bool> supportsAlternateIcons() async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Fetches the current iconName
  ///
  /// Returns `null` if the current icon is the default icon
  Future<String?> getAlternateIconName() async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Sets [iconName] as the current icon for the app
  ///
  /// [iOS]: Use [showAlert] at your own risk as it uses a private/undocumented API to
  /// not show the icon change alert. By default, it shows the alert
  /// Reference: https://stackoverflow.com/questions/43356570/alternate-icon-in-ios-10-3-avoid-notification-dialog-for-icon-change/49730130#49730130
  ///
  /// Throws a [PlatformException] with description if
  /// it can't find [iconName] or there's any other error
  Future setAlternateIconName(String? iconName, {bool showAlert = true}) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Fetches the icon batch number
  ///
  /// The default value of this property is `0` (to show no batch)
  Future<int> getApplicationIconBadgeNumber() async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Sets [batchIconNumber] as the batch number for the current icon for the app
  ///
  /// Set to 0 (zero) to hide the badge number.
  ///
  /// Throws a [PlatformException] in case an error
  Future setApplicationIconBadgeNumber(int batchIconNumber) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }
}
