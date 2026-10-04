abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;

  ToggleNotifications(this.enabled);
}
