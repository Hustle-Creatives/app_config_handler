#include "include/app_config_handler/app_config_handler_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "app_config_handler_plugin.h"

void AppConfigHandlerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  app_config_handler::AppConfigHandlerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
