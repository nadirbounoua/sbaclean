import 'package:sbaclean/models/city.dart';
import 'package:meta/meta.dart';


@immutable
class CityState {

  final List<City> cities;


  CityState({this.cities = const []});

  CityState copyWith({
    List<City> cities,
  }) {
    print(cities);
    return CityState(
        cities: cities ?? this.cities
    );
  }

  factory CityState.fromJSON(Map<String, dynamic> json) => new CityState(
    cities: json['cities'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'cities': this.cities
  };
}