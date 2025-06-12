#ifndef FLUTTER_PLUGIN_APP_CONFIG_HANDLER_PLUGIN_H_
#define FLUTTER_PLUGIN_APP_CONFIG_HANDLER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace app_config_handler {

class AppConfigHandlerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AppConfigHandlerPlugin();

  virtual ~AppConfigHandlerPlugin();

  // Disallow copy and assign.
  AppConfigHandlerPlugin(const AppConfigHandlerPlugin&) = delete;
  AppConfigHandlerPlugin& operator=(const AppConfigHandlerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace app_config_handler

#endif  // FLUTTER_PLUGIN_APP_CONFIG_HANDLER_PLUGIN_H_
