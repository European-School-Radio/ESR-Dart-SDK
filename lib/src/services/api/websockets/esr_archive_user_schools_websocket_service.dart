import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/status.dart' as status;
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_archive_user_schools_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ESRArchiveUserSchoolsByArchiveWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int? _archiveId;
  ESRArchiveUserSchoolsSorting _sorting = ESRArchiveUserSchoolsSorting.userFirstName;
  ESRSortingDirections _direction = ESRSortingDirections.asc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRArchiveUserSchoolsListResults> _controller =
  StreamController<ESRArchiveUserSchoolsListResults>.broadcast();

  ESRArchiveUserSchoolsByArchiveWebsocketService(){
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/archive-users-schools-by-archive/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/archive-users-schools-by-archive/";
    }
  }

  void setLanguage(ESRLang language) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage() {
    return _language;
  }

  void setPageSize(int newMaxItems) {
    _pageSize = newMaxItems;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page_size": _pageSize.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPageSize() {
    return _pageSize;
  }

  void setArchiveId(int newArchiveId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _archiveId = newArchiveId;
  }

  int? getArchiveId(){
    return _archiveId;
  }

  void setSorting(ESRArchiveUserSchoolsSorting newSorting) {
    _sorting = newSorting;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "sort": _sorting.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRArchiveUserSchoolsSorting getSorting(){
    return _sorting;
  }

  void setDirection(ESRSortingDirections newDirection){
    _direction = newDirection;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "direction": _direction.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRSortingDirections getDirection(){
    return _direction;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("archive_id", _archiveId.toString());
    urlBuilder.addQueryParam("sort", _sorting.value.toString());
    urlBuilder.addQueryParam("direction", _direction.value.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRArchiveUserSchoolsListResults.fromJson(jsonMessage));
      },
      onError: (error) {
        _isConnected = false;
        disconnect();
      },
      onDone: () {
        _isConnected = false;
      },
    );
  }

  Stream<ESRArchiveUserSchoolsListResults> get stream => _controller.stream;

  StreamSubscription<ESRArchiveUserSchoolsListResults> addListener(
      void Function(ESRArchiveUserSchoolsListResults event) onData,
      {Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void sendJson(Map<String, dynamic> message) {
    if (!_isConnected) {
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }

    String jsonMessage = jsonEncode(message);

    _channel?.sink.add(jsonMessage);
  }

  void disconnect() {
    if (!_isConnected){
      return;
    }

    _isConnected = false;

    _channel?.sink.close(status.normalClosure);
    _channel = null;

    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}