import 'package:flutter/material.dart';

class ThemeToggle extends StatefulWidget {
  @override
  _ThemeToggleState createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Modo Escuro'),
      value: isDark,
      onChanged: (value) {
        setState(() => isDark = value);
        // Aqui você ligaria ao PreferencesService para salvar a escolha.
      },
    );
  }
}
