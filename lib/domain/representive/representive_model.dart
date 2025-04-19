import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RepresentiveModel extends Equatable {
  final Timestamp createdAt;
  final String district;
  final String division;
  final String fatherName;
  final String localAddress;
  final String motherName;
  final String name;
  final String nidOrBirthCertificate;
  final String phoneNumber;
  final String post;
  final String thana;
  const RepresentiveModel({
    required this.createdAt,
    required this.district,
    required this.division,
    required this.fatherName,
    required this.localAddress,
    required this.motherName,
    required this.name,
    required this.nidOrBirthCertificate,
    required this.phoneNumber,
    required this.post,
    required this.thana,
  });

  RepresentiveModel copyWith({
    Timestamp? createdAt,
    String? district,
    String? division,
    String? fatherName,
    String? localAddress,
    String? motherName,
    String? name,
    String? nidOrBirthCertificate,
    String? phoneNumber,
    String? post,
    String? thana,
  }) {
    return RepresentiveModel(
      createdAt: createdAt ?? this.createdAt,
      district: district ?? this.district,
      division: division ?? this.division,
      fatherName: fatherName ?? this.fatherName,
      localAddress: localAddress ?? this.localAddress,
      motherName: motherName ?? this.motherName,
      name: name ?? this.name,
      nidOrBirthCertificate:
          nidOrBirthCertificate ?? this.nidOrBirthCertificate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      post: post ?? this.post,
      thana: thana ?? this.thana,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt.toString(),
      'district': district,
      'division': division,
      'fatherName': fatherName,
      'localAddress': localAddress,
      'motherName': motherName,
      'name': name,
      'nidOrBirthCertificate': nidOrBirthCertificate,
      'phoneNumber': phoneNumber,
      'post': post,
      'thana': thana,
    };
  }

  factory RepresentiveModel.fromMap(Map<String, dynamic> map) {
    return RepresentiveModel(
      createdAt:
          map['createdAt'] is Timestamp
              ? map['createdAt']
              : Timestamp.fromMillisecondsSinceEpoch(
                int.parse(map['createdAt'].toString()),
              ),
      district: map['district'] ?? '',
      division: map['division'] ?? '',
      fatherName: map['fatherName'] ?? '',
      localAddress: map['localAddress'] ?? '',
      motherName: map['motherName'] ?? '',
      name: map['name'] ?? '',
      nidOrBirthCertificate: map['nidOrBirthCertificate'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      post: map['post'] ?? '',
      thana: map['thana'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RepresentiveModel.fromJson(String source) =>
      RepresentiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RepresentiveModel(createdAt: $createdAt, district: $district, division: $division, fatherName: $fatherName, localAddress: $localAddress, motherName: $motherName, name: $name, nidOrBirthCertificate: $nidOrBirthCertificate, phoneNumber: $phoneNumber, post: $post, thana: $thana)';
  }

  @override
  List<Object> get props {
    return [
      createdAt,
      district,
      division,
      fatherName,
      localAddress,
      motherName,
      name,
      nidOrBirthCertificate,
      phoneNumber,
      post,
      thana,
    ];
  }
}
