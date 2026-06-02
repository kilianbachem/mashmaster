class BeerStyle {
  final String name;
  final double minCo2GramsPerLiter;
  final double maxCo2GramsPerLiter;

  const BeerStyle({
    required this.name,
    required this.minCo2GramsPerLiter,
    required this.maxCo2GramsPerLiter,
  });

  double get midCo2GramsPerLiter =>
      (minCo2GramsPerLiter + maxCo2GramsPerLiter) / 2;
}

/// Brewing-style carbonation ranges, sourced from a German homebrewing
/// reference table. Style names are kept in German for consistency
/// with the source and German hobby brewing convention.
const List<BeerStyle> beerStyles = [
  BeerStyle(
    name: 'Altbier',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Amber Kellerbier',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'American Amber Ale',
    minCo2GramsPerLiter: 4.5,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'American Barleywine',
    minCo2GramsPerLiter: 3.5,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'American Brown Ale',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'American IPA',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'American Lager',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'American Light Lager',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'American Pale Ale',
    minCo2GramsPerLiter: 4.5,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'American Porter',
    minCo2GramsPerLiter: 4.5,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'American Stout',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'American Strong Ale',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'American Wheat Beer',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Australian Sparkling Ale',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.5,
  ),
  BeerStyle(
    name: 'Baltic Porter',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Belgian Blond Ale',
    minCo2GramsPerLiter: 5.1,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Belgian Dark Strong Ale',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Belgian Dubbel',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Belgian Golden Strong Ale',
    minCo2GramsPerLiter: 5.1,
    maxCo2GramsPerLiter: 6.7,
  ),
  BeerStyle(
    name: 'Belgian IPA',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Belgian Pale Ale',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 6.7,
  ),
  BeerStyle(
    name: 'Belgian Tripel',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.7,
  ),
  BeerStyle(
    name: 'Berliner Weisse',
    minCo2GramsPerLiter: 5.1,
    maxCo2GramsPerLiter: 8.6,
  ),
  BeerStyle(
    name: 'Best Bitter',
    minCo2GramsPerLiter: 3.1,
    maxCo2GramsPerLiter: 4.9,
  ),
  BeerStyle(
    name: 'Bière de Garde',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Black IPA',
    minCo2GramsPerLiter: 4.5,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Blonde Ale',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'British Brown Ale',
    minCo2GramsPerLiter: 3.5,
    maxCo2GramsPerLiter: 4.9,
  ),
  BeerStyle(
    name: 'British Golden Ale',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'British Strong Ale',
    minCo2GramsPerLiter: 4.1,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Brown IPA',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'California Common',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Cream Ale',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Czech Amber Lager',
    minCo2GramsPerLiter: 4.5,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Czech Dark Lager',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Czech Pale Lager',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'Czech Premium Pale Lager',
    minCo2GramsPerLiter: 4.5,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Dark Mild',
    minCo2GramsPerLiter: 3.5,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'Doppelbock',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Double IPA',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Dunkles Bock',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Dunkles Weissbier',
    minCo2GramsPerLiter: 5.7,
    maxCo2GramsPerLiter: 8.0,
  ),
  BeerStyle(
    name: 'Eisbock',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'English Barleywine',
    minCo2GramsPerLiter: 3.1,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'English IPA',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'English Porter',
    minCo2GramsPerLiter: 3.5,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'Festbier',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Flanders Red Ale',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Foreign Extra Stout',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Fruit Lambic',
    minCo2GramsPerLiter: 3.5,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'German Helles Exportbier',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'German Leichtbier',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'German Pils',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(name: 'Gose', minCo2GramsPerLiter: 5.1, maxCo2GramsPerLiter: 6.7),
  BeerStyle(name: 'Gueuze', minCo2GramsPerLiter: 5.1, maxCo2GramsPerLiter: 6.7),
  BeerStyle(
    name: 'Helles Bock',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Historical Beer - Other',
    minCo2GramsPerLiter: 3.5,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Imperial Stout',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'International Amber Lager',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'International Dark Lager',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'International Pale Lager',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'Irish Extra Stout',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'Irish Red Ale',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'Irish Stout',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'Kentucky Common',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(name: 'Kölsch', minCo2GramsPerLiter: 4.7, maxCo2GramsPerLiter: 6.1),
  BeerStyle(name: 'Lambic', minCo2GramsPerLiter: 3.5, maxCo2GramsPerLiter: 5.5),
  BeerStyle(
    name: 'Lichtenhainer',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.3,
  ),
  BeerStyle(
    name: 'London Brown Ale',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'Munich Dunkel',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Munich Helles',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(name: 'Märzen', minCo2GramsPerLiter: 4.9, maxCo2GramsPerLiter: 5.9),
  BeerStyle(name: 'NEIPA', minCo2GramsPerLiter: 3.9, maxCo2GramsPerLiter: 4.7),
  BeerStyle(
    name: 'Oatmeal Stout',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Old Ale',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'Ordinary Bitter',
    minCo2GramsPerLiter: 3.1,
    maxCo2GramsPerLiter: 4.9,
  ),
  BeerStyle(
    name: 'Oud Bruin',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Pale Kellerbier',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Piwo Grodziskie',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.1,
  ),
  BeerStyle(
    name: 'Pre-Prohibition Lager',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Pre-Prohibition Porter',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Rauchbier',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Red IPA-Red',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Roggenbier',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.1,
  ),
  BeerStyle(
    name: 'Rye IPA',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(name: 'Sahti', minCo2GramsPerLiter: 3.1, maxCo2GramsPerLiter: 4.9),
  BeerStyle(name: 'Saison', minCo2GramsPerLiter: 5.5, maxCo2GramsPerLiter: 6.9),
  BeerStyle(
    name: 'Schwarzbier',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Scottish Export',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'Scottish Heavy',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.5,
  ),
  BeerStyle(
    name: 'Scottish Light',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.1,
  ),
  BeerStyle(
    name: 'Specialty IPA',
    minCo2GramsPerLiter: 4.3,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Strong Bitter',
    minCo2GramsPerLiter: 3.1,
    maxCo2GramsPerLiter: 4.9,
  ),
  BeerStyle(
    name: 'Sweet Stout',
    minCo2GramsPerLiter: 3.9,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Trappist Single',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 6.7,
  ),
  BeerStyle(
    name: 'Tropical Stout',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.7,
  ),
  BeerStyle(
    name: 'Vienna Lager',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Wee Heavy',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'Weissbier',
    minCo2GramsPerLiter: 5.7,
    maxCo2GramsPerLiter: 8.8,
  ),
  BeerStyle(
    name: 'Weizenbock',
    minCo2GramsPerLiter: 4.9,
    maxCo2GramsPerLiter: 6.9,
  ),
  BeerStyle(
    name: 'Wheatwine',
    minCo2GramsPerLiter: 3.7,
    maxCo2GramsPerLiter: 5.3,
  ),
  BeerStyle(
    name: 'White IPA-White',
    minCo2GramsPerLiter: 4.7,
    maxCo2GramsPerLiter: 5.9,
  ),
  BeerStyle(
    name: 'Witbier',
    minCo2GramsPerLiter: 5.1,
    maxCo2GramsPerLiter: 6.7,
  ),
];
