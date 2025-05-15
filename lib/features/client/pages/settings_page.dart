import 'package:flutter/material.dart';
import '../../../shared/widgets/theme_toggle.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Center(child: ThemeToggle()),
    );
  }
}
