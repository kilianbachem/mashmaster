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
  BeerStyle(name: 'Altbier', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Ale', minCo2GramsPerLiter: 3.0, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Berliner Weiße', minCo2GramsPerLiter: 5.5, maxCo2GramsPerLiter: 7.0),
  BeerStyle(name: 'Bockbier', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Dinkelbier', minCo2GramsPerLiter: 5.5, maxCo2GramsPerLiter: 7.0),
  BeerStyle(name: 'Dortmunder Export', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 4.9),
  BeerStyle(name: 'Kölsch', minCo2GramsPerLiter: 5.0, maxCo2GramsPerLiter: 5.5),
  BeerStyle(name: 'Maibock', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Malzbier', minCo2GramsPerLiter: 4.0, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Märzenbier', minCo2GramsPerLiter: 4.6, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Münchner Export', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 4.9),
  BeerStyle(name: 'Pilsner', minCo2GramsPerLiter: 5.0, maxCo2GramsPerLiter: 5.5),
  BeerStyle(name: 'Porter', minCo2GramsPerLiter: 4.0, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Rauchbier', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Roggenbier', minCo2GramsPerLiter: 5.0, maxCo2GramsPerLiter: 6.0),
  BeerStyle(name: 'Schwarzbier', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 5.0),
  BeerStyle(name: 'Stout', minCo2GramsPerLiter: 3.0, maxCo2GramsPerLiter: 4.0),
  BeerStyle(name: 'Weizenbier', minCo2GramsPerLiter: 5.5, maxCo2GramsPerLiter: 7.0),
  BeerStyle(name: 'Wiener Export', minCo2GramsPerLiter: 4.5, maxCo2GramsPerLiter: 4.9),
];
