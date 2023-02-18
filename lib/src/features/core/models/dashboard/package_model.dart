import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PackageModel {
  final String? id;
  final String containerName;
  final String partNumber;
  final String caseNumber;
  final String quantity;
  final String dateReceived;
  final String? dateShipped;
  final String? dateDelivered;
  final String? trailerNumber;
  final String? status;

  /// Constructor
  const PackageModel(
      {this.id,
      required this.containerName,
      required this.partNumber,
      required this.caseNumber,
      required this.quantity,
      required this.dateReceived,
      this.dateShipped,
      this.dateDelivered,
      this.trailerNumber,
      this.status});

  /// convert model to Json structure so that you can it to store data in Firesbase
  toJson() {
    return {
      "ContainerName": containerName,
      "PartNumber": partNumber,
      "CaseNumber": caseNumber,
      "Quantity": quantity,
      "DateReceived": dateReceived,
      "DateShipped": dateShipped,
      "DateDelivered": dateDelivered,
      "TrailerNumber": trailerNumber,
      "Status": status,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory PackageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PackageModel(
        id: document.id,
        containerName: data["ContainerName"],
        partNumber: data["PartNumber"],
        caseNumber: data["CaseNumber"],
        quantity: data["Quantity"],
        dateReceived: data["DateReceived"],
        dateShipped: data["DateShipped"],
        dateDelivered: data["DateDelivered"],
        trailerNumber: data["TrailerNumber"],
        status: data["Status"]);
  }

  factory PackageModel.fromGoogleSnapshot(Map<String, dynamic> snapshot) {
    var epoch = DateTime(1899, 12, 30);
    var date = DateTime.parse(epoch
        .add(Duration(days: int.parse(snapshot["DateReceived"])))
        .toString());
    var dateReceived = "${date.month}/${date.day}/${date.year}";
    var dateShipped;
    var dateDelivered;

    if (snapshot["DateShipped"] != 'null') {
      date = DateTime.parse(epoch
          .add(Duration(days: int.parse(snapshot["DateShipped"])))
          .toString());
      dateShipped = "${date.month}/${date.day}/${date.year}";
    } else {
      dateShipped = '';
    }

    if (snapshot["DateDelivered"] != 'null') {
      date = DateTime.parse(epoch
          .add(Duration(days: int.parse(snapshot["DateDelivered"])))
          .toString());
      dateDelivered = "${date.month}/${date.day}/${date.year}";
    } else {
      dateDelivered = '';
    }

    return PackageModel(
        id: snapshot["Id"],
        containerName: snapshot["ContainerName"],
        partNumber: snapshot["PartNumber"],
        caseNumber: snapshot["CaseNumber"],
        quantity: snapshot["Quantity"],
        dateReceived: dateReceived,
        dateShipped: dateShipped,
        dateDelivered: dateDelivered,
        trailerNumber: snapshot["TrailerNumber"] ?? '',
        status: snapshot["Status"] ?? '');
  }

  toJsonG() {
    return {
      "Id": const Uuid().v4(),
      "ContainerName": containerName,
      "PartNumber": partNumber,
      "CaseNumber": caseNumber,
      "Quantity": quantity,
      "DateReceived": dateReceived,
      "DateShipped": dateShipped,
      "DateDelivered": dateDelivered,
      "TrailerNumber": trailerNumber,
      "Status": status,
    };
  }
}
