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
