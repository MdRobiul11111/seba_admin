import 'dart:convert';

import 'package:equatable/equatable.dart';

class BloodDonerModel extends Equatable {
  final String age;
  final bool asABloodDonor;
  final String bloodGroup;
  final String currentDate;
  final String district;
  final String division;
  final bool donationComplete;
  final String localAddress;
  final String name;
  final String phoneNumber;
  final String profileImage;
  final String thana;
  const BloodDonerModel({
    required this.age,
    required this.asABloodDonor,
    required this.bloodGroup,
    required this.currentDate,
    required this.district,
    required this.division,
    required this.donationComplete,
    required this.localAddress,
    required this.name,
    required this.phoneNumber,
    required this.profileImage,
    required this.thana,
  });

  BloodDonerModel copyWith({
    String? age,
    bool? asABloodDonor,
    String? bloodGroup,
    String? currentDate,
    String? district,
    String? division,
    bool? donationComplete,
    String? localAddress,
    String? name,
    String? phoneNumber,
    String? profileImage,
    String? thana,
  }) {
    return BloodDonerModel(
      age: age ?? this.age,
      asABloodDonor: asABloodDonor ?? this.asABloodDonor,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      currentDate: currentDate ?? this.currentDate,
      district: district ?? this.district,
      division: division ?? this.division,
      donationComplete: donationComplete ?? this.donationComplete,
      localAddress: localAddress ?? this.localAddress,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      thana: thana ?? this.thana,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'asABloodDonor': asABloodDonor,
      'bloodGroup': bloodGroup,
      'current_date': currentDate,
      'district': district,
      'division': division,
      'donationComplete': donationComplete,
      'localAddress': localAddress,
      'name': name,
      'phoneNumber': phoneNumber,
      'profile_image': profileImage,
      'thana': thana,
    };
  }

  factory BloodDonerModel.fromMap(Map<String, dynamic> map) {
    return BloodDonerModel(
      age: map['age'] ?? 'N/A',
      asABloodDonor: map['asABloodDonor'] ?? false,
      bloodGroup: map['bloodGroup'] ?? 'N/A',
      currentDate: map['current_date'] ?? 'N/A',
      district: map['district'] ?? 'N/A',
      division: map['division'] ?? 'N/A',
      donationComplete: map['donationComplete'] ?? false,
      localAddress: map['localAddress'] ?? 'N/A',
      name: map['name'] ?? 'N/A',
      phoneNumber: map['phoneNumber'] ?? 'N/A',
      profileImage: map['profile_image'] ?? 'N/A',
      thana: map['thana'] ?? 'N/A',
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodDonerModel.fromJson(String source) =>
      BloodDonerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BloodDonerModel(age: $age, asABloodDonor: $asABloodDonor, bloodGroup: $bloodGroup, currentDate: $currentDate, district: $district, division: $division, donationComplete: $donationComplete, localAddress: $localAddress, name: $name, phoneNumber: $phoneNumber, profileImage: $profileImage, thana: $thana)';
  }

  @override
  List<Object> get props {
    return [
      age,
      asABloodDonor,
      bloodGroup,
      currentDate,
      district,
      division,
      donationComplete,
      localAddress,
      name,
      phoneNumber,
      profileImage,
      thana,
    ];
  }
}
