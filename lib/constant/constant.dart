import 'dart:ui';

import 'package:flutter/material.dart';

class ConstantColors {
  ConstantColors._();
  static final primary = _genreateColorFromHex('#1497A6');
  static get primaryVariant => _genreateColorFromHex('#D9D2B0');
  static final secondary = _genreateColorFromHex('#F22727');
  static get secondaryVariant => _genreateColorFromHex('#0b7a8b');
  static final onSecundary = Colors.amberAccent;
  static get surface => primary;
  static final background = _genreateColorFromHex('#0D0D0D');
  static get error => Colors.red;

  static get onPrimary => Colors.white;

  static get onSurface => Colors.black;

  static get onBackground => Colors.cyan;

  static get onError => Colors.purple;

  static get brightness => Brightness.dark;

  static ColorScheme get colorScheme => ColorScheme(
      primary: primary,
      primaryVariant: primaryVariant,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
      surface: surface,
      background: background,
      error: error,
      onPrimary: onPrimary,
      onSecondary: onSecundary,
      onSurface: onSurface,
      onBackground: onBackground,
      onError: onError,
      brightness: brightness);
}

const MOVIE_MEDIA_TYPE = 'movie';
const TV_MEDIA_TYPE = 'tv';
const CALL_BACK_SCHEME = 'moviecatalog';

Color _genreateColorFromHex(String hex) {
  final hexFormated = hex.replaceFirst('#', '');
  return Color(int.parse('0xff$hexFormated'));
}
