class VpnModel {
  late final String hostName;
  late final String ip;
  late final String ping;
  late final String countryLongName;
  late final String countryShortName;
  late final String base64OpenVPNConfigurationData;
  late final int speed;
  late final int vpnSessionsNum;

  VpnModel({
    required this.hostName,
    required this.ip,
    required this.ping,
    required this.countryLongName,
    required this.countryShortName,
    required this.base64OpenVPNConfigurationData,
    required this.speed,
    required this.vpnSessionsNum,
  });

  VpnModel.fromJson(Map<String, dynamic> json) {
    hostName = json['HostName'] ?? "";
    ip = json['IP'] ?? "";
    ping = json['Ping'].toString();
    speed = json['Speed'] ?? 0;
    countryLongName = json['CountryLong'] ?? "";
    countryShortName = json['CountryShort'] ?? "";
    vpnSessionsNum = json['NumVpnSessions'] ?? 0;
    base64OpenVPNConfigurationData = json['OpenVPN_ConfigData_Base64'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'HostName': hostName,
      'IP': ip,
      'Ping': ping,
      'Speed': speed,
      'CountryLong': countryLongName,
      'CountryShort': countryShortName,
      'NumVpnSessions': vpnSessionsNum,
      'OpenVPN_ConfigData_Base64': base64OpenVPNConfigurationData,
    };
  }
}
