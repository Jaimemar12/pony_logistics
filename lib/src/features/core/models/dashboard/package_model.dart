import 'package:cloud_firestore/cloud_firestore.dart';

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
}
