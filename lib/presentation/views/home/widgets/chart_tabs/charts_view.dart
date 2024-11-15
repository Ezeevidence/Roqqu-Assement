import 'package:flutter/material.dart';
import 'package:k_chart_plus/k_chart_plus.dart';
import 'package:provider/provider.dart';
import 'package:roqqu/utils/extensions/theme_extensions.dart';
import '../../../../../view_model/binance_data_view_model.dart';

class ChartsView extends StatefulWidget {
  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
  String selectedTimeframe = "1D";
  bool showDepthView = false;

  void _changeTimeframe(String newTimeframe) {
    setState(() {
      selectedTimeframe = newTimeframe;
    });
    Provider.of<BinanceDataViewModel>(context, listen: false)
        .updateTimeFrame(newTimeframe);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeframeSelector(
          selectedTimeframe: selectedTimeframe,
          onTimeframeChanged: _changeTimeframe,
        ),
        ChartSwitcher(
          showDepthView: showDepthView,
          onToggleView: (bool value) {
            setState(() {
              showDepthView = value;
            });
          },
        ),
        Expanded(
          child: Consumer<BinanceDataViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.candlestickData.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }


              List<KLineEntity> candles = viewModel.allCandlestickData.map((data) {
                return KLineEntity.fromCustom(
                  open: data['open'],
                  high: data['high'],
                  low: data['low'],
                  close: data['close'],
                  vol: data['volume'],
                  time: data['timestamp'],
                );
              }).toList();
              DataUtil.calculate(candles);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: KChartWidget(
                  candles,
                  ChartStyle(),
                  ChartColors(
                    bgColor: Colors.transparent,
                    gridColor: Colors.transparent,
                    ma5Color: Colors.transparent,
                    ma10Color: Colors.transparent,
                    ma30Color: Colors.transparent,                  ),
                  isLine: false,
                  mainState: MainState.MA,
                  volHidden: false,
                  fixedLength: 2,
                  isTrendLine: false,
                  timeFormat: TimeFormat.YEAR_MONTH_DAY,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TimeframeSelector extends StatelessWidget {
  final String selectedTimeframe;
  final Function(String) onTimeframeChanged;

  const TimeframeSelector({
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TimeframeButton("1H", selectedTimeframe, onTimeframeChanged),
          TimeframeButton("4H", selectedTimeframe, onTimeframeChanged),
          TimeframeButton("1D", selectedTimeframe, onTimeframeChanged),
          TimeframeButton("1W", selectedTimeframe, onTimeframeChanged),
          TimeframeButton("1M", selectedTimeframe, onTimeframeChanged),
        ],
      ),
    );
  }
}


class ChartSwitcher extends StatelessWidget {
  final bool showDepthView;
  final Function(bool) onToggleView;

  const ChartSwitcher({
    required this.showDepthView,
    required this.onToggleView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChartSwitcherButton(
            title: "Trading view",
            isSelected: !showDepthView,
            onPressed: () => onToggleView(false),
          ),
          ChartSwitcherButton(
            title: "Depth",
            isSelected: showDepthView,
            onPressed: () => onToggleView(true),
          ),
        ],
      ),
    );
  }
}


class TimeframeButton extends StatelessWidget {
  final String timeframe;
  final String selectedTimeframe;
  final Function(String) onTimeframeChanged;

  const TimeframeButton(this.timeframe, this.selectedTimeframe, this.onTimeframeChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDarkMode;
    final isSelected = selectedTimeframe == timeframe;

    return GestureDetector(
      onTap: () => onTimeframeChanged(timeframe),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? isDarkMode? const Color(0xFF1E2030):  Colors.grey[300]: isDarkMode? Colors.transparent: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          timeframe,
          style: TextStyle(
            color: isSelected ? isDarkMode? Colors.white : Colors.grey[700]: isDarkMode? Colors.grey[300]: Colors.grey[700],
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ChartSwitcherButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onPressed;

  const ChartSwitcherButton({
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDarkMode;

    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ?

          isDarkMode ?  Colors.grey[700] :  Colors.grey[300]: isDarkMode? Colors.transparent: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? isDarkMode?Colors.grey[100] : Colors.grey[700]: isDarkMode? Colors.grey[300]: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}