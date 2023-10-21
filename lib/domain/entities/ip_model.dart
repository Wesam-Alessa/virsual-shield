class IpModel {
  late final String countryName;
  late final String regionName;
  late final String cityName;
  late final String zipcode;
  late final String timezone;
  late final String internetServiceProvider;
  late final String query;

  IpModel({
    required this.countryName,
    required this.regionName,
    required this.cityName,
    required this.zipcode,
    required this.timezone,
    required this.internetServiceProvider,
    required this.query,
  });

  IpModel.fromJson(Map<String, dynamic> json) {
    countryName = json['country'] ?? "";
    regionName = json['regionName'] ?? "";
    cityName = json['city'] ?? "";
    zipcode = json['zip'] ?? "";
    timezone = json['timezone'] ?? "UnKnown";
    internetServiceProvider = json['isp'] ?? "UnKnown";
    query = json['query'] ?? "Not available";
  }
}
