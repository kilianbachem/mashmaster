import 'package:flutter/material.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';
import 'package:mashmaster/router/routes.dart';

class HomeScreenCardData {
  final IconData icon;
  final Color color;
  final String location;
  final String Function(Translations t) getTitle;
  final String Function(Translations t) getSubtitle;

  HomeScreenCardData({
    required this.icon,
    required this.color,
    required this.location,
    required this.getTitle,
    required this.getSubtitle,
  });
}

final List<HomeScreenCardData> homeScreenCardDetails = [
  HomeScreenCardData(
    icon: Icons.clean_hands_rounded,
    color: Colors.blue,
    location: HomeRoute.dosagecalc.path,
    getTitle: (t) => t.home_screen_cards.dosage_calc.title,
    getSubtitle: (t) => t.home_screen_cards.dosage_calc.subtitle,
  ),
  HomeScreenCardData(
    icon: Icons.calculate_rounded,
    color: Colors.teal,
    location: HomeRoute.generalcalc.path,
    getTitle: (t) => t.home_screen_cards.general_calc.title,
    getSubtitle: (t) => t.home_screen_cards.general_calc.subtitle,
  ),
  HomeScreenCardData(
    icon: Icons.scale_rounded,
    color: Colors.amber,
    location: HomeRoute.brewcalc.path,
    getTitle: (t) => t.home_screen_cards.brew_calc.title,
    getSubtitle: (t) => t.home_screen_cards.brew_calc.subtitle,
  ),
  HomeScreenCardData(
    icon: Icons.format_underline_outlined,
    color: Colors.deepOrange,
    location: HomeRoute.unitcalc.path,
    getTitle: (t) => t.home_screen_cards.unit_calc.title,
    getSubtitle: (t) => t.home_screen_cards.unit_calc.subtitle,
  ),
  HomeScreenCardData(
    icon: Icons.grain_rounded,
    color: Colors.brown,
    location: HomeRoute.mashcalc.path,
    getTitle: (t) => t.home_screen_cards.mash_calc.title,
    getSubtitle: (t) => t.home_screen_cards.mash_calc.subtitle,
  ),
];
