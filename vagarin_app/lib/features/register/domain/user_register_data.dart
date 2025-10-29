import 'dart:io';
import 'package:geolocator/geolocator.dart';

class UserRegisterData {
  final String name;
  final String username;
  final DateTime birthday;
  final String bio;
  final String phone;
  final File? imageFile;
  final Position? geoPosition;
  final bool hasActiveNotifications;

  final String firebaseUid;

  UserRegisterData({
    required this.name,
    required this.username,
    required this.birthday,
    required this.bio,
    required this.phone,
    this.imageFile,
    this.geoPosition,
    required this.hasActiveNotifications,
    required this.firebaseUid,
  });
}
