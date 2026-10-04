import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nana/features/services/local_notification_service.dart';
import 'package:nana/features/setting/screens/bloc/setting_event.dart';
import 'package:nana/features/setting/screens/bloc/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_loadSettings);
    on<ToggleNotifications>(_toggleNotifications);
  }

  Future<void> _loadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    final prefs = await SharedPreferences.getInstance();

    final enabled = prefs.getBool('notifications_enabled') ?? true;

    emit(SettingsLoaded(notificationsEnabled: enabled));
  }

  Future<void> _toggleNotifications(
    ToggleNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('notifications_enabled', event.enabled);
    if (event.enabled) {
      final productName = prefs.getString('pending_product_name');

      if (productName != null && productName.isNotEmpty) {
        await scheduleCartNotification(productName: productName);
      }
    } else {
      await cancelCartNotification();
    }

    emit(SettingsLoaded(notificationsEnabled: event.enabled));
  }

  Future<void> cancelCartNotification() async {}
}
