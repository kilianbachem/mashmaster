import 'package:flutter/material.dart';
import 'package:mashmaster/helpers/home_screen_card_data.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';
import 'package:mashmaster/widgets/screen_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final cards = homeScreenCardDetails;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          // childAspectRatio is driven by AspectRatio(1) inside ScreenCard,
          // so we set it to 1 here to match.
          childAspectRatio: 1,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final data = cards[index];
          return ScreenCard(
            title: data.getTitle(t),
            subtitle: data.getSubtitle(t),
            icon: data.icon,
            color: data.color,
            location: data.location,
          );
        },
      ),
    );
  }
}
