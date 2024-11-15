import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class BinanceService {
  WebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _dataController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _candlestickDataController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _orderbookDataController = StreamController.broadcast();

  Stream<Map<String, dynamic>> get dataStream => _dataController.stream;
  Stream<Map<String, dynamic>> get candlestickDataStream => _candlestickDataController.stream;
  Stream<Map<String, dynamic>> get orderbookDataStream => _orderbookDataController.stream;

  // Keep track of the current timeframe
  String _currentTimeframe = '1d';

  BinanceService() {
    _initializeData('1d');
  }

  Future<void> _initializeData(String timeframe) async {
    // First fetch historical data
    await _fetchHistoricalData(timeframe);
    // Then connect to websocket for real-time updates
    _connect(timeframe);
  }

  Future<void> _fetchHistoricalData(String timeframe) async {
    try {
      // Convert timeframe to interval parameter
      String interval = _convertTimeframeToInterval(timeframe);

      // Fetch last 500 candles (or adjust as needed)
      final response = await http.get(
          Uri.parse('https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=$interval&limit=500')
      );

      if (response.statusCode == 200) {
        List<dynamic> klines = jsonDecode(response.body);

        for (var kline in klines) {
          Map<String, dynamic> candleData = {
            't': kline[0], // Open time
            'o': kline[1], // Open
            'h': kline[2], // High
            'l': kline[3], // Low
            'c': kline[4], // Close
            'v': kline[5], // Volume
          };
          _candlestickDataController.add(candleData);
        }
      }
    } catch (e) {
      print('Error fetching historical data: $e');
    }
  }

  String _convertTimeframeToInterval(String timeframe) {
    // Convert timeframe format to Binance API interval format
    switch (timeframe.toUpperCase()) {
      case '1H': return '1h';
      case '2H': return '2h';
      case '4H': return '4h';
      case '1D': return '1d';
      case '1W': return '1w';
      case '1M': return '1M';
      default: return '1d';
    }
  }

  void _connect(String timeframe) {
    _currentTimeframe = timeframe;
    final interval = _convertTimeframeToInterval(timeframe);

    final url = 'wss://stream.binance.com:9443/stream?streams=btcusdt@ticker/btcusdt@depth20@100ms/btcusdt@kline_$interval';
    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel!.stream.listen(
          (data) {
        final jsonData = jsonDecode(data);
        final streamType = jsonData['stream'];

        if (streamType.contains('@kline')) {
          // Only emit if it's a new candle or the current candle closed
          final candleData = jsonData['data']['k'];
          if (candleData['x'] == true) { // Candle closed
            _candlestickDataController.add(candleData);
          }
        } else if (streamType.contains('@depth')) {
          _orderbookDataController.add(jsonData['data']);
        } else {
          _dataController.add(jsonData);
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
        _reconnect(timeframe);
      },
      onDone: () {
        print('WebSocket connection closed. Reconnecting...');
        _reconnect(timeframe);
      },
    );
  }

  void _reconnect(String timeframe) {
    Future.delayed(Duration(seconds: 5), () => _connect(timeframe));
  }

  void changeTimeFrame(String timeframe) {
    if (_currentTimeframe != timeframe) {
      _channel?.sink.close();
      _initializeData(timeframe);
    }
  }

  void dispose() {
    _channel?.sink.close();
    _dataController.close();
    _candlestickDataController.close();
    _orderbookDataController.close();
  }
}