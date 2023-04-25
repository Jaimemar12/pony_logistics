import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "pony-logistics",
  "private_key_id": "721e19adfc25b3d5cde4411fd0abc69410a0b682",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEi/gT0wEc868y\nAXRbi4+RfiulolP8hoIEEjQuKNgG5ppk820LXcbCqK5lomnQEOOU0eMhjSMw64GG\nVB27YyXJ5FeRb48wUylbR4ZIjjUHBmY2Ndx5TnqTKItfD9+3MT/Hr8gbZCxpBjjx\nTIG8Eh/xw26t8D/kGogL377HHNY1wtocCeVHLcMjZFVtGLSFz+63tgPa2Eg5FdJ5\nebmnpbO5TxUFaIht4ierQcz/RfORd22rygdtwq5GvboEY+TzAHRJ10xMhp4UMCcW\nd5F1nbcWO07Q0YwlNvckL2CQQlwUwGguEB1PCaUt8prPcYOk4aELKFIX8yvSFkFD\njOBEsgunAgMBAAECggEADmy+tGcYM1GXyjc8x2/gMGDj/4ArjXfVDfXEukiJcO7h\nZkb5T0wUHNA4GxccO0bUtQ+MYwzSiDIYlk0RG4zExrhJTFAK4GnnZJ7Etl7SzyUD\nQQzwlT89vr7LL8W1+QzBGLzda6k38INM5Y9kYXMBFi4Y2Y+C2OZblWeClGbDj+a6\ndT8/zQ182eQAoP40nfNO187+ScZEJKctv4CKsWlzd8sIfc+FXyayyCEw4qhLmDgo\nHnaQKpLaUpzIMCuLdsuaKzY6kr+4/t1aG22WYWvYqBc6mCtxD3SLkb4lPMptU62L\nh0iXTeOBEyqPVQ1j7KC08J98a8kgnCXBwMZDhOl/HQKBgQD4oOu1gHZ3ctb7LaNr\nPDRoayKW+UeUo6I85iqGm0yk4Hy21Hj56+7xBigXFZ9DNQ0I2UByJyjOW2Q4lRLQ\nSunAU+4ThEOUO43QZt/KdikfebWcbkLY0fesE1WiiI4w7aAQFB9WuD0xeUlQi2Dp\n0LdHkaBTbJizWSyBQOlfst5m0wKBgQDKX7/lsI8v+aMMnJLxsJUxavwKmNldrNpi\nJrCUoy/OgyzH5yYDXsGV2sdRjrd3v0+Kur7PNAHM9ucQ9OpAyb2bfwWzCifRp4r3\nPWYO69JDSiwwt9/B+enbqTGUyN9jqZ8T9OzwXMJFNIjL969cgSn9t1rt4V+cv275\nyuBgDJHrXQKBgQCbR83O7uuOULAJ8ggFenV03aydxBS7tbMm+82FgkrNEtNxUKQ5\n2uvBpsm1GTD9xY1dgGoqoWBv+U5PtHMqmg8BqqmfkNSwKL26cfXFOiUW3mnZyFeB\nmSlpVC4As+6yikaUpCyqeajmVEzAvDwL6+n8DeynDcUVBlWwaD0ZItqaNwKBgGeJ\n2WowjPGkrPD04pFZINupus3JKdytZQW2eb1ySDFGF5EnB+HNhwmeZz+o3uEbNhzq\nMllcaFdvMwUP6RHApYt6z3WsinbPW1/nP+H+cRMQTc+XI5ngvO8vfzh6FSCuVb8m\nHltTeeliWWLRlByl0NAIETOHjR1rK+INFALQK4/ZAoGBANQDXQMGRW5Vr4qxaoqk\n3Mk8cm25SNsswGZgsYVXwjP6HTzZ7Hoq/L/s8j6wNVvFsMG8H3ocmk80HyLnpOWv\njCdYzFE/jR5YrgL4EXSFG3PALgu6lOH6Rc52gKXsjQ6drBt6qtEmeAT4jYgvyUod\n7HKf08dSYi+dyJ8q04HmVQZf\n-----END PRIVATE KEY-----\n",
  "client_email": "pony-logistics@pony-logistics.iam.gserviceaccount.com",
  "client_id": "112179619266629818690",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pony-logistics%40pony-logistics.iam.gserviceaccount.com"
}  
  ''';

  static const _spreadsheetId = '1hdKnI4OXB_TqqMbugXrGO08tXl8adJYZw-Q9fUQaw-Y';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    final spreadsheet = await _gSheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorksheet(spreadsheet, title: 'Users');
  }

  static Future<Worksheet> _getWorksheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  /// Store user data
  // Future<void> createUser(UserModel user) async {
  //   await _db.collection("Users").add(user.toJson()).whenComplete(() {
  //     Get.snackbar("Success", "You account has been created.",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green.withOpacity(0.1),
  //         colorText: Colors.green,
  //         duration: const Duration(seconds: 2));
  //   }).catchError((error, stackTrace) {
  //     Get.snackbar("Error", "Something went wrong. Try again",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.redAccent.withOpacity(0.1),
  //         colorText: Colors.red,
  //         duration: const Duration(seconds: 2));
  //   });
  // }

  Future<void> createUser(UserModel user) async {
    if (_userSheet == null) return;
    var json = user.toJsonG();
    while (await _userSheet!.values.map.rowByKey(json["Id"]) != null) {
      json = user.toJsonG();
    }
    await _userSheet!.values.map.appendRow(json);
  }

  /// Fetch User Specific details
  // Future<UserModel> getUserDetails(String email) async {
  //   final snapshot =
  //       await _db.collection("Users").where("Email", isEqualTo: email).get();
  //   final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  //   return userData;
  // }

  /// Fetch All Users
  // Future<List<UserModel>> getAllUsers() async {
  //   final snapshot = await _db.collection("Users").get();
  //   final userData =
  //       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  //   return userData;
  // }

  Future<UserModel?> getUserDetails(String email) async {
    var users = await getAllUsers();
    for (int i = 0; i < users.length; i++) {
      if (email == users[i].email) {
        return users[i];
      }
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    if (_userSheet == null) return <UserModel>[];
    final snapshot = await _userSheet!.values.map.allRows();
    return snapshot == null
        ? <UserModel>[]
        : snapshot.map((e) => UserModel.fromGoogleSnapshot(e)).toList();
  }

  /// Update User details
  Future<void> updateUserRecord(UserModel user) async {
    final cellsOfRow = await _userSheet!.cells.rowByKey(user.id.toString());
    if (cellsOfRow == null) return;
    int index = 0;
    for (var cell in cellsOfRow) {
      switch (index) {
        case 0:
          cell.value = user.fullName;
          break;
        case 1:
          cell.value = user.email;
          break;
        case 2:
          cell.value = user.phoneNo;
          break;
        case 3:
          cell.value = user.password;
          break;
      }
      index++;
    }
    await _userSheet!.cells.insert(cellsOfRow);
  }

  /// Delete User Data
  Future<bool> deleteUser(String id) async {
    final index = await _userSheet!.values.rowIndexOf(id);
    return index == -1
        ? Future<bool>.value(false)
        : _userSheet!.deleteRow(index);
  }
}
