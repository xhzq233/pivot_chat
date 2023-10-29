import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _lightScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
final _darkScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark);
const _barColor = CupertinoDynamicColor.withBrightness(color: Color(0xF0F9F9F9), darkColor: Color(0xF01D1D1D));

final lightThemeData = ThemeData(
  colorScheme: _lightScheme,
  useMaterial3: true,
  platform: TargetPlatform.iOS,
  brightness: Brightness.light,
  cupertinoOverrideTheme: CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: _lightScheme.primary,
    primaryContrastingColor: CupertinoColors.systemBackground,
    applyThemeToAll: true,
    barBackgroundColor: _barColor,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  ),
);

final darkThemeData = ThemeData(
  colorScheme: _darkScheme,
  useMaterial3: true,
  platform: TargetPlatform.iOS,
  brightness: Brightness.dark,
  cupertinoOverrideTheme: CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkScheme.primary,
    primaryContrastingColor: CupertinoColors.systemBackground,
    applyThemeToAll: true,
    barBackgroundColor: _barColor,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  ),
);
