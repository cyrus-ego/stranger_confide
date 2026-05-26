import 'dart:async';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/token_storage.dart';
import '../models/response/queue_status_response.dart';

const _defaultBaseUrl = 'https://c44e-1-54-23-149.ngrok-free.app';

sealed class MatchmakingSocketEvent {}

class SocketQueueJoined extends MatchmakingSocketEvent {
  SocketQueueJoined(this.data);
  final QueueStatusResponse data;
}

class SocketQueuePosition extends MatchmakingSocketEvent {
  SocketQueuePosition(this.data);
  final QueueStatusResponse data;
}

class SocketMatchFound extends MatchmakingSocketEvent {
  SocketMatchFound(this.roomId, this.partnerId);
  final String roomId;
  final String? partnerId;
}

class SocketQueueTimeout extends MatchmakingSocketEvent {}

class SocketError extends MatchmakingSocketEvent {
  SocketError(this.message);
  final String message;
}

class SocketConnected extends MatchmakingSocketEvent {}

class SocketDisconnected extends MatchmakingSocketEvent {
  SocketDisconnected(this.reason);
  final String reason;
}

@lazySingleton
class MatchmakingSocketService {
  MatchmakingSocketService(this._tokenStorage);

  final TokenStorage _tokenStorage;

  io.Socket? _socket;
  final _eventController =
      StreamController<MatchmakingSocketEvent>.broadcast();

  Stream<MatchmakingSocketEvent> get events => _eventController.stream;

  bool get isConnected => _socket?.connected ?? false;

  void connect() {
    if (_socket != null) {
      disconnect();
    }

    final rawBaseUrl =
        dotenv.env['API_BASE_URL'] ?? '$_defaultBaseUrl/api';
    final serverUrl = rawBaseUrl.replaceAll(RegExp(r'/api/?$'), '');
    final token = _tokenStorage.accessToken ?? '';

    log('MatchmakingSocket: connecting to $serverUrl/matchmaking',
        name: 'Socket');

    _socket = io.io(
      '$serverUrl/matchmaking',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(10)
          .setReconnectionDelay(2000)
          .setReconnectionDelayMax(10000)
          .build(),
    );

    _socket!
      ..onConnect((_) {
        log('MatchmakingSocket: connected', name: 'Socket');
        _eventController.add(SocketConnected());
      })
      ..onDisconnect((reason) {
        log('MatchmakingSocket: disconnected ($reason)', name: 'Socket');
        _eventController.add(SocketDisconnected(reason.toString()));
      })
      ..onConnectError((error) {
        log('MatchmakingSocket: connect error $error', name: 'Socket');
        _eventController.add(SocketError(error.toString()));
      })
      ..onError((error) {
        log('MatchmakingSocket: error $error', name: 'Socket');
        _eventController.add(SocketError(error.toString()));
      })
      ..on('queue:joined', (data) {
        log('MatchmakingSocket: queue:joined $data', name: 'Socket');
        final parsed = _parseQueueData(data);
        if (parsed != null) {
          _eventController.add(SocketQueueJoined(parsed));
        }
      })
      ..on('queue:position', (data) {
        log('MatchmakingSocket: queue:position $data', name: 'Socket');
        final parsed = _parseQueueData(data);
        if (parsed != null) {
          _eventController.add(SocketQueuePosition(parsed));
        }
      })
      ..on('match:found', (data) {
        log('MatchmakingSocket: match:found $data', name: 'Socket');
        final map = data is Map<String, dynamic> ? data : <String, dynamic>{};
        _eventController.add(SocketMatchFound(
          (map['roomId'] ?? '').toString(),
          map['partnerId']?.toString(),
        ));
      })
      ..on('queue:timeout', (_) {
        log('MatchmakingSocket: queue:timeout', name: 'Socket');
        _eventController.add(SocketQueueTimeout());
      })
      ..on('error', (data) {
        log('MatchmakingSocket: server error $data', name: 'Socket');
        final msg = data is Map ? (data['message'] ?? data.toString()) : '$data';
        _eventController.add(SocketError(msg.toString()));
      });

    _socket!.connect();
  }

  void emitQueueSync() {
    _socket?.emit('queue:sync');
    log('MatchmakingSocket: emitted queue:sync', name: 'Socket');
  }

  void emitQueueLeave() {
    _socket?.emit('queue:leave');
    log('MatchmakingSocket: emitted queue:leave', name: 'Socket');
  }

  void disconnect() {
    _socket?.dispose();
    _socket = null;
    log('MatchmakingSocket: disposed', name: 'Socket');
  }

  @disposeMethod
  void dispose() {
    disconnect();
    _eventController.close();
  }

  QueueStatusResponse? _parseQueueData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return QueueStatusResponse.fromJson(data);
    }
    if (data is Map) {
      return QueueStatusResponse.fromJson(
        data.map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    return null;
  }
}
