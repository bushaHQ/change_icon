import Flutter
import UIKit

public class TailiconPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tailicon", binaryMessenger: registrar.messenger())
        let instance = SwiftBushaiconPlugin()
        
        channel.setMethodCallHandler { call, result in
            if "SupportsAlternateIcons" == call.method {
                if #available(iOS 10.3, *) {
                    result(UIApplication.shared.supportsAlternateIcons)
                } else {
                    result(FlutterError(code: "UNAVAILABLE",message: "Not supported on iOS ver < 10.3",details: nil))
                }
            } else if "GetAlternateIconName" == call.method {
                if #available(iOS 10.3, *) {
                    result(UIApplication.shared.alternateIconName)
                } else {
                    result(FlutterError(code: "UNAVAILABLE", message: "Not supported on iOS ver < 10.3",details: nil))
                }
            } else if "SetAlternateIconName" == call.method {
                if #available(iOS 10.3, *) {
                    do {
                        guard let iconName = call.arguments as? String else {
                            throw NSError(domain: "", code: 0, userInfo: nil)
                        }
                        UIApplication.shared.setAlternateIconName(iconName) { error in
                            if let error = error {
                                result(FlutterError(code: "Failed to set icon",message: error.localizedDescription,details: nil))
                            } else {
                                result(nil)
                            }
                        }
                    } catch {
                        result(FlutterError(code: "Failed to set icon",
                                            message: error.localizedDescription,
                                            details: nil))
                    }
                } else {
                    result(FlutterError(code: "UNAVAILABLE",
                                        message: "Not supported on iOS ver < 10.3",
                                        details: nil))
                }
            } else if "mGetApplicationIconBadgeNumber" == call.method {
                result(UIApplication.shared.applicationIconBadgeNumber)
            } else if "mSetApplicationIconBadgeNumber" == call.method {
                if #available(iOS 10.0, *) {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { granted, error in
                        if granted {
                            do {
                                guard let batchIconNumber = call.arguments as? Int else {
                                    throw NSError(domain: "", code: 0, userInfo: nil)
                                }
                                UIApplication.shared.applicationIconBadgeNumber = batchIconNumber
                                result(nil)
                            } catch {
                                result(FlutterError(code: "Failed to set batch icon number",
                                                    message: error.localizedDescription,
                                                    details: nil))
                            }
                        } else {
                            result(FlutterError(code: "Failed to set batch icon number",
                                                message: "Permission denied by the user",
                                                details: nil))
                        }
                    }
                } else {
                    do {
                        guard let batchIconNumber = call.arguments as? Int else {
                            throw NSError(domain: "", code: 0, userInfo: nil)
                        }
                        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: .badge, categories: nil))
                        UIApplication.shared.applicationIconBadgeNumber = batchIconNumber
                        result(nil)
                    } catch {
                        result(FlutterError(code: "Failed to set batch icon number",
                                            message: error.localizedDescription,
                                            details: nil))
                    }
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
