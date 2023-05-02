import 'dart:math';

import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';

class ReportRepository extends GetxController {
  static ReportRepository get instance => Get.find();

  static getCredentials() {
    const androidJson = r'''
    {
              "type": "service_account",
              "project_id": "pony-logistics-android",
              "private_key_id": "3c62ad1e4a42fa5372d767821b3af86160d19d31",
              "private_key":
                  "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDNUWEWMHKAKO9C\nK1ZdkdJ5rVvETwQBz1Jsiu9Ofr/gA5gRP4iurFMbwO2foHYaEzENh0hUBC3bC6Dq\ndfqCgmlmcT9gfMzyTj+ML5Uyo1bfe4Vy6OnTW9m/+LUnX2aLsTNb6w2+ePxz6urX\n37ZsPmd3AsvT1ApYquWaSOSuI4nKl4UyOXUM4djy52yPgQCynyy/pJswHinIeDsb\nqpv6v8ZaWjP0kmLSl1SxuV04BXc8yl18b6dKfhUFDvNm0Vo7s7stsFSToiA6qwFg\nvThlv78Iif/i0REfMukNSRkBjq8hAXelAwojfEvgUapSec3ELRr6hip9JsFKY0/J\noT4zEr5rAgMBAAECggEAChEgvthxRMdns8mG2opOf5jNvw+raqCiXKATS7il6nNC\nqYCBUHndOVHO/4dRQxtdya6wZS4vRruIkEu96gLq7WhFaz2zRCOCCiWVyH3UbJtp\n16XZO9EXxB81rVCIKUvu8LrTBFvPmlS9CbNLsShTel+wuW9+x7TZZ88wfI6m2uqs\nX9//1sQ3iYTuamPPzfUv7RChRGSctunLSS+mgh3SpruV0KWhkow1ZabHmfzspVhU\nncXhaFul9qMQoerh0uHtf3FD7fCSU5wOgl6CLL6WMpuZNfBc3Y194bjYF/fYCW8S\nWmWDnnEouxD7QF0zTsPMqkZb1qGGlpEff3kO5ze4AQKBgQD+a7MODKgGlJU+QrLX\nyySnnkN5looDmBFwEyx6zvQPX1UbVdVJAsqohv5nziYp4jyiXk9FqSTKPRXekcsJ\ni9ORHXVx7gJCd1DFpuLLXtKAWuvp2kckSMS7n/7Pf/MH3XfNx3dc2nDIFd3Gqclk\nPG5LvfG3GdcuVtad31DZinz2gQKBgQDOl6aBOvacX+CGu4aaNeYv+MHtkylpd3pg\nJZOcdnHk7mnb8pf1QaLTG/N564erf/kSzCKSNXJ+phyeUGO07ZyTVBl5jGjSK5Sz\nP0u5P81bDRN6ZhphABhJiF9jJdXdH7R9ImOuq3PkiwG56XMlp+VqDWNQJh+R4boZ\nwURpvD126wKBgQD992xJfgDMcM151QLJvpLcb3NTkB488DOX+MvR23xtS/Cc1NWP\niCXcjMSvwmz+KkP0oMfo9asv5kJKZqaS5O1QUmPGUpwW1Rvf8XM7J3BhiGEukyGo\n6qrX0CJ/520mUMEivRY9riAe2xUDFsFeOaSwHu+Go1jVfQHHngAK599OAQKBgQC0\nyAXfTj6hZlDu9ch6x7GvxunEwKNbdD71Rcye/RL7dxnRa79H0fDu9aWgydeF3s2R\ngmq6MOUJKMkgTE6D8+2xCsXkFFdhmttb44abC9bi11V1JUXuHgwixKBb/a7g+i6R\n1fcO0V/v3ShcjInDqOFbZW3DpCi6GqIkiXgZYq0SkwKBgQDf51a2G8hALDGWXqKk\nTPbt/d3mv2PR4TSldKTu6JXUhJqil8H9gkApsYFejSMYCbt62YPZKBMtnl/HHviK\nutop6BpX/y1MHNf6OF/1pKt7K8JlCnbP1hIVrdo5U855HXBagVyFcqFNAMeKiJ3t\nsWiwF8bqYsYOPJ5/n6E7g+5mBA==\n-----END PRIVATE KEY-----\n",
              "client_email":
                  "pony-logistics-android@pony-logistics-android.iam.gserviceaccount.com",
              "client_id": "103133430203224975631",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url":
                  "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url":
                  "https://www.googleapis.com/robot/v1/metadata/x509/pony-logistics-android%40pony-logistics-android.iam.gserviceaccount.com"
            }
    ''';

    const iosJson = r'''
    {
              "type": "service_account",
              "project_id": "pony-logistics-iphone",
              "private_key_id": "116024b52d70d78779dc5234bb61d1007eb3d4fd",
              "private_key":
                  "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC2rMDP53v3pOVk\nmOnlwXx32lxvULxPJprmNkBDQxCqnXhaVOWzMrX37iAoNxLmPxL9z+yCgWJEsLCq\nVS4B4mJfYYy/V6doSb5f5/bJBWFPKZObURLl+FvKgRncZeQvh49xDuQRL/EbUdYl\n3qgPW9DWducy+fs8d5JcE5swSwuPQ2Itxu7M0ZPfDcbUUKL9TF1EHEN7dZiarlTp\nfoDseU8ib5sFjP5wT+01W6xDxGpb8Yi6JxlkAeA+vadn3Y9lZFiCxnps90ckmuhO\ndQsr+vaMFDI8Dkaaac9xSrD/yVYXLrgwuDArAQiERKHDrT9qDF+Um20flmTPlB4l\nz3TBIElrAgMBAAECggEAPsQAw+6vo5le0D/SLgVbNPssQ3skGLYVBwCg9/t1IIpW\nrgL5oabM61FAb1DtB3uolNj6VKUMFLn5Ga2Gz1LvpgIokB4YATdFWEKlgtB8bOzG\nMNmcerPpJh1Ru26vBr23RYtuRZGJcG+f+wcUC6LqkKXuLo/CCTa0bTq3WdKPODvC\nt5GgNJyr+N6ueb2XJlqCGqh0Uqovhz7DE0w2tqaOpubtrUgkOj5Wl0PmPUsPDyng\nUFe9Wxa5oQt/KjkqhGckSXfblwWUFfM2odiS51PD2vAM+Wbggh4+RwFgwM+dcFyR\nOqELdOj610xAf16lBBYX7CuDweXRMAZ8db6K+kn7wQKBgQD57hOMOouqVSXs+2Db\nZ4cFNuW+ggAWfRkJe6gYDWDbzUKF1sr2PY/kffKullnsyY8LGgmpRz19GscwWd3v\nsdJoEijyWZjn9JvWqHrxz0ESHStkEUG3iRu6HiTEzSwAYuR9VH99X1jeKo9uvjI4\n8RMSZ+m99Rq5wY8+pA6kG3LZuwKBgQC7HIWpqx10slNFDJ4wFiwz3PsM0Ua8PR3a\nA69S8Vyl1quQarIZRQZIdCuPaQ19nWEEy+3lxNFuK7QRzvGtar8FAqIRJjRi1LDp\n+3p9C0AknOKq0RoSUbBN4ZQznRbonFMf+Jg3lQ88mvlvvAag2dha3Ac+6xLKhmrG\nxBbj9ug8EQKBgCZeSzfy4PAURE8+RB9KpGrDg7+cW4EYUVioWCThIOZ9e2HqmJv2\n1XlBcJkm0cVNKB2PML6BBkqHat7cXProNKHvb8PMx3GMlsP8d2tZ4uZx/fBNyeXw\nMYaADCr+SGwCwosPBsdrdMwegoiAwFsHf2MK+tJDp4eu1FvMecbtw9LzAoGAVYsC\nqMEsZE+qtiTApWddqhBbTk7XMfQXE7cfjqH+I2tzYEEHT3o5FyLVT2lN26H52wGI\nr8U9okqktoeQAiKNVjMP+RsoVA69Gxv3sfdUyehX0JRsgPeLzO9WnAozkQD3F+TF\nYpPpNWH8q9KgjSVLPq7dOSyrmJ+/bUP02x/kqKECgYBhn6sT48b72jadO3Kn8Y+/\n9XXG9vZDY5YG3ng2sbAOAk0a72dNAwXrBKTZkIIsZnryDfQA8SiF2m8cAGYG3wKk\nCD6ke2PLoX+UtDwmFVvxHFlCAs8YvTQtS4Z+zSxzl+An5ITNvniGA3A0QJqa12O4\nPrEVz7DCyk3U88YeeBe7pw==\n-----END PRIVATE KEY-----\n",
              "client_email":
                  "pony-logistics-iphone@pony-logistics-iphone.iam.gserviceaccount.com",
              "client_id": "104306788861632544479",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url":
                  "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url":
                  "https://www.googleapis.com/robot/v1/metadata/x509/pony-logistics-iphone%40pony-logistics-iphone.iam.gserviceaccount.com"
            }
            ''';

    const windowsJson = r'''
    {
              "type": "service_account",
              "project_id": "pony-logistics-windows",
              "private_key_id": "9dcfd3626a58ed29a047ade4977be7f676174916",
              "private_key":
                  "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDSaWcr+CIQ5v9C\nZepm3FTuSNuYKlv4AB76BLfiUFmoV3IypVXJWNoNZ+v4BY0ZuXDmknp616/NiE0W\n6FWo+PXDhBRq6G+7IyeumNsGJV7PFAlCqganbdhBULW2rQ/o4/kuylbprKdNvmnl\nfBl85CeMatA7S2+QajsnsHUsK80jC9UVxYSj3gyKU3Fn7aLqyBDMzmIMaysnHmp9\navIxyrmAV+gX6jMafyzF7ggO1MALxaNuVwB496k2YRYYlaG1n4VcCEwYyMI2kqTj\nmlBAaMcgBPysSAdaJ9W3BE549JDYWHBakuB22A+tUdgAkxzsrzQ1BgM3NwtcF97m\no52+1U2pAgMBAAECggEADccDj6w7dM5fU/Zu6wXN1N117YiGhZ5iaN4SuVGoET8K\nlfjf/WNhQcP2fkLEyrSrCRn5xZ3mX8enPpL/euU0WHVHTfnCySbj5AmTu9sKEnae\nJZyS+3cUlDBH+bpqwoXc7NyoZLwep1dKwVFHLPeWhFoBIQTPPQ5Lqc1i2r3SfJMd\nEdFVxLzIWgevuSWcBNf9EqJw2sCfwKC7rqKqimS7z7HxUfc+YXVjWdHm37utYmSR\ng1JQeJdO6HLXks9TtvDpqBz0j3sBIgJurHDW3NJ6wVCT3MzKpCO7RX+AuvUE77IZ\nME/FCfLH4nrA8qH5XMhkKdpLAETmadBuUtj3UT/GxQKBgQD2VrVWy4yNyBKUtPiF\nFsqqykVLcTzDVwJUOKUfEZnLNolLSFtsMXC9rfxKeZ9580OKSO1sMg63Iq8HMc9G\nL6Zrqm+h5t8xP4ehGs9vrvLziTO+ZzJsWnf/vGvA3KNOAmrv9+OnUQPzik/hO4rB\nFSjppLzaCCmbCPM5TGMnIYj39QKBgQDaqfr7JdLekCPLXSq1MZrhkMzMgGWaKaeW\n8K5tz5gUR1iU6Wo3g7MB1eeWYXA1C3YRdQES418nksNuiUykb+hUxE6L5LaZH0b8\n/bjEsvd4TCcQKbFmvnXXIOTPYlEPAugQlH/8AIJn2thbp7stwctoAR0CUGQu2qlj\niBG2eoNSZQKBgQC/WvnAs5u6Y2mzpKTM1biXVUrg4NTftQ41GE+EQ+rhBbs/BLUn\n5Xv7jFTIEZRFaifUGvR7sKLntgSapSGrFsbDKgFPlgVYv03/YtEyo4dMkQ7l4Eo2\nC0zeFqLpjTs6FPy27iwkw/U60P1eLB+L/4DphjPBdsfDC//MSb9YHV/FpQKBgQDX\nYzY5KzHCT4Mir7wAzUL9y28gRZ1PNJbDJIL84c6wsvJ7hEw/MLgkJ7q+M26eoZKE\ncZdELrmtNnDRMedP1neo/9FLFVgUDm4TiCz3fD4tvf2Ae0EmrpdO+DTKXtLvkXJb\n2psS9MF/YV9bMSY8VTdyVB5qCBwW1wahZwfjklxGzQKBgQCr3XyVGoEK7Tj5H38O\n7j1LgHBf0GPD1mHuZHxodSi5fV7lFfsgU+IEdGOV3RF4HDBUxKn90lHc0AaEOVXJ\nNB/7is7FUw6BtNCv+pWZhLOPbYf0UTKlLtJYaY+7q45QeyB6WRrUt4U77pmh/w8f\nV9j2zcTGApemcr2ncdWEKvA79Q==\n-----END PRIVATE KEY-----\n",
              "client_email":
                  "pony-logistics-windows@pony-logistics-windows.iam.gserviceaccount.com",
              "client_id": "102822915988012726895",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url":
                  "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url":
                  "https://www.googleapis.com/robot/v1/metadata/x509/pony-logistics-windows%40pony-logistics-windows.iam.gserviceaccount.com"
            }
            ''';

    const macJson = r'''
    {
              "type": "service_account",
              "project_id": "pony-logistics-mac",
              "private_key_id": "3e4ae220af2436d581429a184c100ccd4aaa030b",
              "private_key":
                  "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCjYRuS1ySNryfT\njBMx013bEodZIbZO4izQLR6QOGLNgyeCHH6UdD0bJx4WJFVpd4wCLBdezEtLXE7K\njAdTPr9Adp2MWRKftWmZCDl/KxXtfAo1MSg/xevcGdVsUOitfRqbWLw2/Dd/ELE3\nhpWN81XjIT3YosDkRo5AVVDeBVhbE3Dxo/1DRqWbYiOeBbLUaZiDIg9rQik7uya+\nouCwzWN0g29sPZrUXGcrYW/Bx6zTXrcwV3SbetOIWtqGZYiL1VHRUph/5F4/5hls\nEtL8JE6BjXK5LI+CvwB6H2A9/VowPRDFRnrl20zc/I9PxHpWCZ/uP7wgnOkFP3Ld\n07cbj+whAgMBAAECggEABKD6eZHJUFZTvVAQi5llyMlEYYeJ/GphmKaJRM7EKWjf\nFHYRGVr6LDo2RXNvokhSdmMSE1LxUWR/V2wvGWPnKUDzEYgaS09pe0U+fnLc1Lw1\nfH7DC0cPecAln0NxWYK/ih75JURUvNpQxbZKixmVteoBE8qF/9xb4dbzoFwIaLQf\nboZBT795Rx4BTlYpoX46U4yn9gL+FgwLDV88udtdVQMW7X+ou8wJXuxsE3Gzdwgf\nJmoGpmvxi7SQMQFtpZHQZ5nAKUM89VLNhnf66tetEtdUnR2V2UHzeoUumwnQyI8T\nbLNuhXwDYYAh62+335jh959Ud2pqHyATAySFsaK7rQKBgQDitYMlFYKTr6TpzMeY\nR9Brtzq0Wu7LXhq/msZYceaZLliYWsn7zkEYhK7Yt1YLQrcDp78rzAJxhq0ChgDn\ntA2MkmjbLtM9PXDbfZ31JHsSelTMYosqnbWBCExLMn/pCMDQiicwMI9yhh6tuuNq\nh4ICX/2EwTxPCPjz2llWHCKWuwKBgQC4fPD2uZVrWYoIJrSSbII4k7r/VPpFkF58\nXHzJ6Adk4qQtR8jjAlLohfFmJRWLV9D+BLutqBgyoGbx90EDVKUy0CoBiA3OCip1\neOdLStNzWe97y+7iQijodFKJTYzBVFwJaza+3syNnGgYRPpXfO1VhCcmduyTdiye\nR+l7N8YQ0wKBgA/Sl0qZS7m/AoWG009fg75g1WoNBqmO8dL5nGpD2NJMF8baX0qB\nxK1PZVyevxSeHWPV61PFM051FdIdRCbnvCJZfZP+mqOljCDljYa0exp5Cz4QiqH4\ny9grmheNeLvs7ngfjEiiuwBFOBLr/j9LIdnElU8UpX7mo2lxjdaitA9NAoGBAKnG\nIKGMS1rMvV+e7tFIldWm7ZEHDIFzx9+95QCRTCyk/NzGkLGHc/CTQoDzY44ltCfv\nBx9Z71q3jcTh+qwr+xJ1yhI6uCmB5WzRZFg/dbNTcjWEiEMjCy5PzZyZBwzqqv/n\n8CtaMPeolYqv/4j/aBEoWjblffR97bWDC/PecaENAoGAZh1wMg8fDr1QluqsOHgl\nMMGTOvBfCAl8l9Yfs9i0P0lDPpAF2NgIT13ZOjtMMi0NzKie3wAwZioRvXi/JIh3\nQYPuWL6MhYzKemeYeV2phYy8kww6LTYBa0xxdWWOelV27PFJNRtlJkvIFD+07qly\nXbzqwlK3STyzafby/fEoHOs=\n-----END PRIVATE KEY-----\n",
              "client_email":
                  "pony-logistics-mac@pony-logistics-mac.iam.gserviceaccount.com",
              "client_id": "108692965736146290787",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url":
                  "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url":
                  "https://www.googleapis.com/robot/v1/metadata/x509/pony-logistics-mac%40pony-logistics-mac.iam.gserviceaccount.com"
            }
            ''';

    switch (Random().nextInt(4)) {
      case 0:
        return androidJson;
      case 1:
        return iosJson;
      case 2:
        return windowsJson;
      case 3:
        return macJson;
    }
  }

  static const _spreadsheetId = '1_N2BegFqfMcCgZK0jRLfmZxBZXK2f4H-_X29oMmsyhM';

  static Future<Worksheet> _getWorksheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  Future<void> generateReport(String packingSlip, String trailerNumber, String carrierName) async {
    List<PackageModel> shippedPackages =
        await GoogleSheetsRepository().getTodayShippedPackages();
    final spreadsheet =
        await GSheets(getCredentials()).spreadsheet(_spreadsheetId);
    final Worksheet reportSheet =
        await _getWorksheet(spreadsheet, title: 'Report');
    reportSheet.clear();
    Map<String, List<PackageModel>> groupedShippedPackages = {};

    if(shippedPackages.isEmpty) {
      return;
    }

    for (PackageModel shippedPackage in shippedPackages) {
      String partNumber = shippedPackage.partNumber;
      if (!groupedShippedPackages.containsKey(partNumber)) {
        groupedShippedPackages[partNumber] = [shippedPackage];
      } else {
        groupedShippedPackages[partNumber]?.add(shippedPackage);
      }
    }

    List<List<String>> multiValues = [
      ["Date Shipped", shippedPackages[0].dateShipped!, "Carrier Name", carrierName],
      ["", "", "Driver Name"],
      ["Part Number", "CNO", "QTY", "Skids", "Total"]
    ];
    int ultimateCount = 0;
    int packageCount = 0;

    for (String partNumber in groupedShippedPackages.keys) {
      int totalCount = 0;
      List<PackageModel>? shippedPackage = groupedShippedPackages[partNumber];
      if (shippedPackage != null) {
        for (int i = 0; i < shippedPackage.length; i++) {
          packageCount += 1;
          List<String> values = [];

          if (i == 0) {
            values.add(shippedPackage[i].partNumber);
          } else {
            values.add('');
          }

          values.add(shippedPackage[i].caseNumber);
          values.add(shippedPackage[i].quantity);
          values.add('1');

          totalCount += int.parse(shippedPackage[i].quantity);

          if (i == shippedPackage.length - 1) {
            values.add(totalCount.toString());
          }

          multiValues.add(values);
        }
        ultimateCount += totalCount;
      }
    }

    reportSheet.values.insertRows(
        1,
        [
          ["Packing Slip #", packingSlip],
          ["", ""],
          ["TRLR#", trailerNumber]
        ],
        fromColumn: 5);
    
    multiValues.add(['', '', ultimateCount.toString(), packageCount.toString()]);
    multiValues.add(['Consignee Signature']);

    reportSheet.values.insertRows(14, multiValues, fromColumn: 2);
  }
}
