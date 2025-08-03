import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      
      
     let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let nativeChannel = FlutterMethodChannel(name: "com.example.method_channel_sample",
                                                       binaryMessenger: controller.binaryMessenger)
      
      
      
      nativeChannel.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              
              switch call.method {
              case "showToast":
                  guard let args = call.arguments as? Dictionary<String, Any>,
                        let message = args["message"] as? String else {
                      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                      return
                  }
                  let duration = args["duration"] as? String ?? "short"
                  self.showToast(message: message, duration: duration)
                  result(nil)
                  
              default:
                  result(FlutterMethodNotImplemented)
              }
          })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    
    private func showToast(message: String, duration: String) {
          DispatchQueue.main.async {
              let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
              
              let controller = self.window?.rootViewController as! FlutterViewController
              controller.present(alert, animated: true)
              
              // Auto dismiss based on duration
              let dismissTime = duration == "long" ? 3.0 : 1.5
              DispatchQueue.main.asyncAfter(deadline: .now() + dismissTime) {
                  alert.dismiss(animated: true)
              }
          }
      }
}
