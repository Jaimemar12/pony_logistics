import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class PackageModel {
  final String? id;
  final String partNumber;
  final String caseNumber;
  final String quantity;
  final String dateDelivered;

  /// Constructor
  const PackageModel(
      {this.id,
      required this.partNumber,
      required this.caseNumber,
      required this.quantity,
      required this.dateDelivered});

  /// convert model to Json structure so that you can it to store data in Firesbase
  toJson() {
    return {
      "PartNumber": partNumber,
      "CaseNumber": caseNumber,
      "Quantity": quantity,
      "DateDelivered": dateDelivered,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory PackageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PackageModel(
      id: document.id,
      partNumber: data["PartNumber"],
      caseNumber: data["CaseNumber"],
      quantity: data["Quantity"],
      dateDelivered: data["DateDelivered"],
    );
  }

  factory PackageModel.fromGoogleSnapshot(Map<String, dynamic> snapshot) {
    var epoch = DateTime(1899, 12, 30);
    var date = DateTime.parse(epoch.add(Duration(days: int.parse(snapshot["DateDelivered"]))).toString());
    var dateDelivered = "${date.month}/${date.day}/${date.year}";

    return PackageModel(
      id: snapshot["Id"],
      partNumber: snapshot["PartNumber"],
      caseNumber: snapshot["CaseNumber"],
      quantity: snapshot["Quantity"],
      dateDelivered: dateDelivered,
    );
  }

  toJsonG() {
    return {
      "Id": const Uuid().v4(),
      "PartNumber": partNumber,
      "CaseNumber": caseNumber,
      "Quantity": quantity,
      "DateDelivered": dateDelivered,
    };
  }
}
