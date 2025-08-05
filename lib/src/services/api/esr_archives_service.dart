import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'dart:io' as io;
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/datetime_formatter.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRArchivesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRArchivesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRArchivesAddResults> addArchive(ESRAddArchive archive, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/archive/add');

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.MultipartRequest('POST', Uri.parse(urlBuilder.build()));
    request.fields.addAll({
      "${archive.name.keys.first}[production]": archive.productionID.toString(),
      "${archive.name.keys.first}[broadcast_day]": ESRDateTimeFormatter.formatDateRequests(archive.broadcastDay),
      "${archive.name.keys.first}[start_time]": ESRDateTimeFormatter.formatTimeRequests(archive.startTime),
      "${archive.name.keys.first}[disabled]": archive.disabled ? "1": "0",
      "${archive.name.keys.first}[duration]": archive.audioFileDuration.toString(),
    });

    for (var nameEntry in archive.name.entries){
      request.fields.addAll({
        "${nameEntry.key}[name]": nameEntry.value
      });
    }

    for (var descriptionEntry in archive.description.entries){
      request.fields.addAll({
        "${descriptionEntry.key}[description]": descriptionEntry.value
      });
    }

    if (archive.transcript != null){
      for (var transcriptEntry in archive.transcript!.entries){
        request.fields.addAll({
          "${transcriptEntry.key}[transcript]": transcriptEntry.value
        });
      }
    }

    if (archive.imageBanner != null && archive.imageBanner.toString().isNotEmpty){
      if (io.File(archive.imageBanner.toString()).existsSync()){
        request.files.add(
            await http.MultipartFile.fromPath('en[banner]', archive.imageBanner.toString())
        );
      }
    }

    if (archive.audioFile.toString().isEmpty || !io.File(archive.audioFile.toString()).existsSync()){
      throw InformationNotValidException("Audio File not found");
    }

    request.files.add(
        await http.MultipartFile.fromPath('en[mp3_file]', archive.audioFile.toString())
    );

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchivesAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}