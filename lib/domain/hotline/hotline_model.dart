import 'dart:convert';

import 'package:equatable/equatable.dart';

class HotlineModel extends Equatable {
  final String websiteLink;
  final String phoneNumber;
  final String facebookLink;
  final String instagramLink;
  final String twitterLink;
  final String youtubeLink;
  final String location;
  const HotlineModel({
    required this.websiteLink,
    required this.phoneNumber,
    required this.facebookLink,
    required this.instagramLink,
    required this.twitterLink,
    required this.youtubeLink,
    required this.location,
  });

  HotlineModel copyWith({
    String? websiteLink,
    String? phoneNumber,
    String? facebookLink,
    String? instagramLink,
    String? twitterLink,
    String? youtubeLink,
    String? location,
  }) {
    return HotlineModel(
      websiteLink: websiteLink ?? this.websiteLink,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      facebookLink: facebookLink ?? this.facebookLink,
      instagramLink: instagramLink ?? this.instagramLink,
      twitterLink: twitterLink ?? this.twitterLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'websiteLink': websiteLink,
      'phoneNumber': phoneNumber,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'twitterLink': twitterLink,
      'youtubeLink': youtubeLink,
      'location': location,
    };
  }

  factory HotlineModel.fromMap(Map<String, dynamic> map) {
    return HotlineModel(
      websiteLink: map['websiteLink'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      facebookLink: map['facebookLink'] ?? '',
      instagramLink: map['instagramLink'] ?? '',
      twitterLink: map['twitterLink'] ?? '',
      youtubeLink: map['youtubeLink'] ?? '',
      location: map['location'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HotlineModel.fromJson(String source) =>
      HotlineModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotlineModel(websiteLink: $websiteLink, phoneNumber: $phoneNumber, facebookLink: $facebookLink, instagramLink: $instagramLink, twitterLink: $twitterLink, youtubeLink: $youtubeLink, location: $location)';
  }

  @override
  List<Object> get props {
    return [
      websiteLink,
      phoneNumber,
      facebookLink,
      instagramLink,
      twitterLink,
      youtubeLink,
      location,
    ];
  }

  factory HotlineModel.empty() {
    return const HotlineModel(
      websiteLink: '',
      phoneNumber: '',
      facebookLink: '',
      instagramLink: '',
      twitterLink: '',
      youtubeLink: '',
      location: '',
    );
  }
}
