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
  final bool approved;
  const AmbulanceModel({
    required this.address,
    required this.district,
    required this.division,
    required this.license,
    required this.name,
    required this.phone,
    required this.thana,
    required this.vehicle,
    required this.approved,
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
    bool? approved,
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
      approved: approved ?? this.approved,
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
      'approved': approved,
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
      approved: map['approved'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmbulanceModel.fromJson(String source) =>
      AmbulanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AmbulanceModel(address: $address, district: $district, division: $division, license: $license, name: $name, phone: $phone, thana: $thana, vehicle: $vehicle, approved: $approved)';
  }

  @override
  List<Object> get props {
    return [
      address,
      district,
      division,
      license,
      name,
      phone,
      thana,
      vehicle,
      approved,
    ];
  }
}
