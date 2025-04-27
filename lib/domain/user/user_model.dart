import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
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
  final String upazila;
  final String? password;
  const UserModel({
    required this.uid,
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
    required this.upazila,
    this.password,
  });

  UserModel copyWith({
    String? uid,
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
    String? upazila,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
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
      upazila: upazila ?? this.upazila,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'age': age,
      'asABloodDonor': asABloodDonor,
      'bloodGroup': bloodGroup,
      'currentDate': currentDate,
      'district': district,
      'division': division,
      'donationComplete': donationComplete,
      'localAddress': localAddress,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'upazila': upazila,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      age: map['age'] ?? '',
      asABloodDonor: map['asABloodDonor'] ?? false,
      bloodGroup: map['bloodGroup'] ?? '',
      currentDate: map['currentDate'] ?? '',
      district: map['district'] ?? '',
      division: map['division'] ?? '',
      donationComplete: map['donationComplete'] ?? false,
      localAddress: map['localAddress'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profileImage: map['profileImage'] ?? '',
      upazila: map['upazila'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, age: $age, asABloodDonor: $asABloodDonor, bloodGroup: $bloodGroup, currentDate: $currentDate, district: $district, division: $division, donationComplete: $donationComplete, localAddress: $localAddress, name: $name, phoneNumber: $phoneNumber, profileImage: $profileImage, upazila: $upazila)';
  }

  @override
  List<Object?> get props {
    return [
      uid,
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
      upazila,
      password,
    ];
  }
}
