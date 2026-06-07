import 'package:flutter/material.dart';
import 'package:mashmaster/helpers/home_screen_card_data.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';
import 'package:mashmaster/widgets/screen_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView(
        children:
            homeScreenCardDetails.map((data) {
              return ScreenCard(
                title: data.getTitle(t),
                subtitle: data.getSubtitle(t),
                icon: data.icon,
                color: data.color,
                location: data.location,
              );
            }).toList(),
      ),
    );
  }
}
