import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String content;
  final bool isAdmin;
  final String messageId;
  final String receiverId;
  final String senderId;
  final DateTime? timestamp;
  final String type;
  final String userName;
  const ChatModel({
    required this.content,
    required this.isAdmin,
    required this.messageId,
    required this.receiverId,
    required this.senderId,
    this.timestamp,
    required this.type,
    required this.userName,
  });

  ChatModel copyWith({
    String? content,
    bool? isAdmin,
    String? messageId,
    String? receiverId,
    String? senderId,
    DateTime? timestamp,
    String? type,
    String? userName,
  }) {
    return ChatModel(
      content: content ?? this.content,
      isAdmin: isAdmin ?? this.isAdmin,
      messageId: messageId ?? this.messageId,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isAdmin': isAdmin,
      'messageId': messageId,
      'receiverId': receiverId,
      'senderId': senderId,
      'timestamp': FieldValue.serverTimestamp(),
      'type': type,
      'userName': userName,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      content: map['content'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      messageId: map['messageId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      senderId: map['senderId'] ?? '',
      timestamp:
          map['timestamp'] != null
              ? (map['timestamp'] as Timestamp).toDate()
              : DateTime.now(),
      type: map['type'] ?? '',
      userName: map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(content: $content, isAdmin: $isAdmin, messageId: $messageId, receiverId: $receiverId, senderId: $senderId, timestamp: $timestamp, type: $type, userName: $userName)';
  }

  @override
  List<Object?> get props {
    return [
      content,
      isAdmin,
      messageId,
      receiverId,
      senderId,
      timestamp,
      type,
      userName,
    ];
  }
}
