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
      this.trailerNumber,
      this.status});

  /// convert model to Json structure so that you can it to store data in Firebase
  toJson() {
    return {
      "ContainerName": containerName,
      "PartNumber": partNumber,
      "CaseNumber": caseNumber,
      "Quantity": quantity,
      "DateReceived": dateReceived,
      "DateShipped": dateShipped,
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
        trailerNumber: data["TrailerNumber"],
        status: data["Status"]);
  }

  factory PackageModel.fromGoogleSnapshot(Map<String, dynamic> snapshot) {
    var epoch = DateTime(1899, 12, 30);
    var date = DateTime.parse(epoch
        .add(Duration(days: int.parse(snapshot["DateReceived"])))
        .toString());
    var dateReceived = "${date.month}/${date.day}/${date.year}";
    String dateShipped;

    if (snapshot["DateShipped"] != 'null') {
      date = DateTime.parse(epoch
          .add(Duration(days: int.parse(snapshot["DateShipped"])))
          .toString());
      dateShipped = "${date.month}/${date.day}/${date.year}";
    } else {
      dateShipped = '';
    }

    return PackageModel(
        id: snapshot["Id"],
        containerName: snapshot["ContainerName"],
        partNumber: snapshot["PartNumber"],
        caseNumber: snapshot["CaseNumber"],
        quantity: snapshot["Quantity"],
        dateReceived: dateReceived,
        dateShipped: dateShipped,
        trailerNumber: snapshot["TrailerNumber"] != 'null'
            ? snapshot["TrailerNumber"]
            : '',
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
      "TrailerNumber": trailerNumber,
      "Status": status,
    };
  }
}
