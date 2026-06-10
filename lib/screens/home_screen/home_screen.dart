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
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          // Each card is at most 200 logical pixels wide.
          // On a ~375 px phone this gives 2 columns; on a 1024 px desktop
          // it gives 5 columns, so all cards fit without scrolling.
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
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
