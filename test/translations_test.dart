import 'package:flutter_test/flutter_test.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';

void main() {
  test('translations test', () async {
    Translations t = await AppLocale.de.build();
    print('Direct field: ${t.home_screen_cards.dosage_calc.title}');
    print('Flat map access: ${t["home_screen_cards.dosage_calc.title"]}');
  });
}
