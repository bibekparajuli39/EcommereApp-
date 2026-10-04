abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool notificationsEnabled;

  SettingsLoaded({required this.notificationsEnabled});
}
