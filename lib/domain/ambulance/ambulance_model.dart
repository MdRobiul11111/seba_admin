import 'dart:convert';

import 'package:equatable/equatable.dart';

class AmbulanceModel extends Equatable {
  final String address;
  final String district;
  final String division;
  final String license;
  final String name;
  final String phone;
  final String thana;
  final String vehicle;
  const AmbulanceModel({
    required this.address,
    required this.district,
    required this.division,
    required this.license,
    required this.name,
    required this.phone,
    required this.thana,
    required this.vehicle,
  });

  AmbulanceModel copyWith({
    String? address,
    String? district,
    String? division,
    String? license,
    String? name,
    String? phone,
    String? thana,
    String? vehicle,
  }) {
    return AmbulanceModel(
      address: address ?? this.address,
      district: district ?? this.district,
      division: division ?? this.division,
      license: license ?? this.license,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      thana: thana ?? this.thana,
      vehicle: vehicle ?? this.vehicle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'district': district,
      'division': division,
      'license': license,
      'name': name,
      'phone': phone,
      'thana': thana,
      'vehicle': vehicle,
    };
  }

  factory AmbulanceModel.fromMap(Map<String, dynamic> map) {
    return AmbulanceModel(
      address: map['address'] ?? '',
      district: map['district'] ?? '',
      division: map['division'] ?? '',
      license: map['license'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      thana: map['thana'] ?? '',
      vehicle: map['vehicle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AmbulanceModel.fromJson(String source) =>
      AmbulanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AmbulanceModel(address: $address, district: $district, division: $division, license: $license, name: $name, phone: $phone, thana: $thana, vehicle: $vehicle)';
  }

  @override
  List<Object> get props {
    return [address, district, division, license, name, phone, thana, vehicle];
  }
}
