import 'dart:async';
import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_follow_schools_sorting.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_follow_users_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ESRFollowSchoolsBySchoolWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int _page = 1;
  int? _schoolId;
  ESRFollowSchoolsSorting _sorting = ESRFollowSchoolsSorting.created;
  ESRSortingDirections _direction = ESRSortingDirections.desc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRFollowSchoolsPaginatedResults> _controller =
  StreamController<ESRFollowSchoolsPaginatedResults>.broadcast();

  ESRFollowSchoolsBySchoolWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/follow-schools-by-school/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/follow-schools-by-school/";
    }
  }

  void setLanguage(ESRLang language) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage() {
    return _language;
  }

  void setPageSize(int newPageSize) {
    _pageSize = newPageSize;

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

  void setPage(int newPage) {
    _page = newPage;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page": _page.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPage() {
    return _page;
  }

  void setSchoolId(int newSchoolId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _schoolId = newSchoolId;
  }

  int? getSchoolId(){
    return _schoolId;
  }

  void setSorting(ESRFollowSchoolsSorting newSorting) {
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

  ESRFollowSchoolsSorting getSorting(){
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
    urlBuilder.addQueryParam("page", _page.toString());
    urlBuilder.addQueryParam("sort", _sorting.value.toString());
    urlBuilder.addQueryParam("direction", _direction.value.toString());

    if (_schoolId != null){
      urlBuilder.addQueryParam("school_id", _schoolId.toString());
    }

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRFollowSchoolsPaginatedResults.fromJson(jsonMessage));
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

  Stream<ESRFollowSchoolsPaginatedResults> get stream => _controller.stream;

  StreamSubscription<ESRFollowSchoolsPaginatedResults> addListener(
      void Function(ESRFollowSchoolsPaginatedResults event) onData,
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