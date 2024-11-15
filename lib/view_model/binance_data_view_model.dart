import 'dart:async';
import 'package:flutter/material.dart';
import '../services/binance_service.dart';

class BinanceDataViewModel extends ChangeNotifier {
  final BinanceService _binanceService;

  double? price;
  double? change;
  double? high;
  double? low;
  List<List<dynamic>> bids = [];
  List<List<dynamic>> asks = [];

  // Store historical and real-time candle data
  final List<Map<String, dynamic>> candlestickData = [];
  Map<String, dynamic>? currentCandle;

  StreamSubscription<Map<String, dynamic>>? _tickerSubscription;
  StreamSubscription<Map<String, dynamic>>? _candlestickSubscription;
  StreamSubscription<Map<String, dynamic>>? _orderbookSubscription;

  BinanceDataViewModel(this._binanceService) {
    _listenToTickerData();
    _listenToCandlestickData();
    _listenToOrderbookData();
  }

  void _listenToTickerData() {
    _tickerSubscription = _binanceService.dataStream.listen((data) {
      final streamType = data['stream'];
      if (streamType == 'btcusdt@ticker') {
        price = double.parse(data['data']['c']);
        change = double.parse(data['data']['P']);
        high = double.parse(data['data']['h']);
        low = double.parse(data['data']['l']);
        notifyListeners();
      }
    });
  }

  void _listenToCandlestickData() {
    _candlestickSubscription = _binanceService.candlestickDataStream.listen((data) {
      final ohlc = {
        'open': double.parse(data['o']),
        'high': double.parse(data['h']),
        'low': double.parse(data['l']),
        'close': double.parse(data['c']),
        'volume': double.parse(data['v']),
        'timestamp': data['t'],
      };

      // If this is historical data or a completed candle, add it to the list
      if (data['x'] == true || !data.containsKey('x')) {
        candlestickData.add(ohlc);
        currentCandle = null;
      } else {
        // Update the current ongoing candle
        currentCandle = ohlc;
      }

      notifyListeners();
    });
  }

  void updateTimeFrame(String timeframe) {
    candlestickData.clear();
    currentCandle = null;
    _binanceService.changeTimeFrame(timeframe);
    notifyListeners();
  }

  void _listenToOrderbookData() {
    _orderbookSubscription = _binanceService.orderbookDataStream.listen((data) {
      bids = List<List<dynamic>>.from(data['bids']);
      asks = List<List<dynamic>>.from(data['asks']);
      notifyListeners();
    });
  }

  List<Map<String, dynamic>> get allCandlestickData {
    if (currentCandle != null) {
      return [...candlestickData, currentCandle!];
    }
    return candlestickData;
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    _candlestickSubscription?.cancel();
    _orderbookSubscription?.cancel();
    _binanceService.dispose();
    super.dispose();
  }
}