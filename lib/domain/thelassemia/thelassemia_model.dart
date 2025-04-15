import 'dart:convert';

import 'package:equatable/equatable.dart';

class ThelassemiaModel extends Equatable {
  final String district;
  final String division;
  final String fatherName;
  final String localAddress;
  final String motherName;
  final String name;
  final String nid;
  final String phone;
  final String post;
  final String representativeName;
  final String representativePhone;
  final String thana;
  const ThelassemiaModel({
    required this.district,
    required this.division,
    required this.fatherName,
    required this.localAddress,
    required this.motherName,
    required this.name,
    required this.nid,
    required this.phone,
    required this.post,
    required this.representativeName,
    required this.representativePhone,
    required this.thana,
  });

  ThelassemiaModel copyWith({
    String? district,
    String? division,
    String? fatherName,
    String? localAddress,
    String? motherName,
    String? name,
    String? nid,
    String? phone,
    String? post,
    String? representativeName,
    String? representativePhone,
    String? thana,
  }) {
    return ThelassemiaModel(
      district: district ?? this.district,
      division: division ?? this.division,
      fatherName: fatherName ?? this.fatherName,
      localAddress: localAddress ?? this.localAddress,
      motherName: motherName ?? this.motherName,
      name: name ?? this.name,
      nid: nid ?? this.nid,
      phone: phone ?? this.phone,
      post: post ?? this.post,
      representativeName: representativeName ?? this.representativeName,
      representativePhone: representativePhone ?? this.representativePhone,
      thana: thana ?? this.thana,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'district': district,
      'division': division,
      'fatherName': fatherName,
      'localAddress': localAddress,
      'motherName': motherName,
      'name': name,
      'nid': nid,
      'phone': phone,
      'post': post,
      'representativeName': representativeName,
      'representativePhone': representativePhone,
      'thana': thana,
    };
  }

  factory ThelassemiaModel.fromMap(Map<String, dynamic> map) {
    return ThelassemiaModel(
      district: map['district'] ?? 'N/A',
      division: map['division'] ?? 'N/A',
      fatherName: map['fatherName'] ?? 'N/A',
      localAddress: map['localAddress'] ?? 'N/A',
      motherName: map['motherName'] ?? 'N/A',
      name: map['name'] ?? 'N/A',
      nid: map['nid'] ?? 'N/A',
      phone: map['phone'] ?? 'N/A',
      post: map['post'] ?? 'N/A',
      representativeName: map['representativeName'] ?? 'N/A',
      representativePhone: map['representativePhone'] ?? 'N/A',
      thana: map['thana'] ?? 'N/A',
    );
  }

  String toJson() => json.encode(toMap());

  factory ThelassemiaModel.fromJson(String source) =>
      ThelassemiaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ThelassemiaModel(district: $district, division: $division, fatherName: $fatherName, localAddress: $localAddress, motherName: $motherName, name: $name, nid: $nid, phone: $phone, post: $post, representativeName: $representativeName, representativePhone: $representativePhone, thana: $thana)';
  }

  @override
  List<Object> get props {
    return [
      district,
      division,
      fatherName,
      localAddress,
      motherName,
      name,
      nid,
      phone,
      post,
      representativeName,
      representativePhone,
      thana,
    ];
  }
}
