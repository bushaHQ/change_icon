import 'package:changeicon/changeicon_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:changeicon/Changeicon.dart';
import 'package:changeicon/Changeicon_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockChangeiconPlatform
    with MockPlatformInterfaceMixin
    implements ChangeiconPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<String?> getAlternateIconName() {
    throw UnimplementedError();
  }
  
  @override
  Future<int> getApplicationIconBadgeNumber() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> initialize({required List<String> classNames}) {
    throw UnimplementedError();
  }
  
  @override
  Future setAlternateIconName(String? iconName, {bool showAlert = true}) {
    throw UnimplementedError();
  }
  
  @override
  Future setApplicationIconBadgeNumber(int batchIconNumber) {
    throw UnimplementedError();
  }
  
  @override
  Future<bool> supportsAlternateIcons() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> switchIconTo({required List<String> classNames}) {
    throw UnimplementedError();
  }
}

void main() {
  final ChangeiconPlatform initialPlatform = ChangeiconPlatform.instance;

  test('$MethodChannelChangeicon is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelChangeicon>());
  });

  test('getPlatformVersion', () async {
    Changeicon ChangeiconPlugin = Changeicon();
    MockChangeiconPlatform fakePlatform = MockChangeiconPlatform();
    ChangeiconPlatform.instance = fakePlatform;

    expect(await ChangeiconPlugin.getPlatformVersion(), '42');
  });
}
