import 'package:flutter/material.dart';
import 'features/client/pages/tracking_page.dart';
import 'features/client/pages/history_page.dart';
import 'features/client/pages/settings_page.dart';
import 'features/driver/pages/deliveries_page.dart';
import 'features/driver/pages/navigation_page.dart';
import 'features/driver/pages/update_status_page.dart';
import 'features/home/home_page.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomePage(),
  '/client/tracking': (context) => TrackingPage(),
  '/client/history': (context) => HistoryPage(),
  '/client/settings': (context) => SettingsPage(),
  '/driver/deliveries': (context) => DeliveriesPage(),
  '/driver/navigation': (context) => NavigationPage(),
  '/driver/update-status': (context) => UpdateStatusPage(),
};