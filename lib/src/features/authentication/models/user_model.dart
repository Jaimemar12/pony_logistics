import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  /// Constructor
  const UserModel(
      {this.id,
      required this.email,
      required this.password,
      required this.fullName,
      required this.phoneNo});

  /// convert model to Json structure so that you can it to store data in Firesbase
  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "PhoneNumber": phoneNo,
      "Password": password,
    };
  }

  toJsonG() {
    return {
      "Id": const Uuid().v4(),
      "FullName": fullName,
      "Email": email,
      "PhoneNumber": phoneNo,
      "Password": password,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data["FullName"],
      email: data["Email"],
      phoneNo: data["PhoneNumber"],
      password: data["Password"],
    );
  }

  factory UserModel.fromGoogleSnapshot(Map<String, dynamic> snapshot) {

    return UserModel(
      id: snapshot["Id"],
      fullName: snapshot["FullName"],
      email: snapshot["Email"],
      phoneNo: snapshot["PhoneNumber"],
      password: snapshot["Password"],
    );
  }
}
