class VpnStatusModel {
  String? byteIn;
  String? byteOut;
  String? durationTime;
  String? lastPacketReceive;

  VpnStatusModel({
    this.byteIn,
    this.byteOut,
    this.durationTime,
    this.lastPacketReceive,
  });

  factory VpnStatusModel.fromJson(Map<String, dynamic> json) => VpnStatusModel(
        byteIn: json['byte_in'],
        byteOut: json['byte_out'],
        durationTime: json['duration'],
        lastPacketReceive: json['last_packet_receive'],
      );

  Map<String, dynamic> toJson() {
    return {
      'byte_in': byteIn,
      'byte_out': byteOut,
      'duration': durationTime,
      'last_packet_receive': durationTime,
    };
  }
}
