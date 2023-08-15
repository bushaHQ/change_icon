import 'package:flutter_test/flutter_test.dart';
import 'package:bushaicon/bushaicon.dart';
import 'package:bushaicon/bushaicon_platform_interface.dart';
import 'package:bushaicon/bushaicon_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBushaiconPlatform
    with MockPlatformInterfaceMixin
    implements BushaiconPlatform {

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
  final BushaiconPlatform initialPlatform = BushaiconPlatform.instance;

  test('$MethodChannelBushaicon is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBushaicon>());
  });

  test('getPlatformVersion', () async {
    Bushaicon bushaiconPlugin = Bushaicon();
    MockBushaiconPlatform fakePlatform = MockBushaiconPlatform();
    BushaiconPlatform.instance = fakePlatform;

    expect(await bushaiconPlugin.getPlatformVersion(), '42');
  });
}
