import 'package:flutter/material.dart';
import 'package:roqqu/presentation/views/home/widgets/chart_tabs/recent_trade_view.dart';
import 'package:roqqu/utils/extensions/theme_extensions.dart';

import 'charts_view.dart';
import 'orderbook_view.dart';



class TabBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDarkMode;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.grey.shade900: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TabBar(

              tabs: [
                Tab(text: "Charts"),
                Tab(text: "Orderbook"),
                Tab(text: "Recent trades"),
              ],
              labelPadding: EdgeInsets.symmetric(horizontal: 8.0), // Reduces tab spacing
            ),
          ),

          // TabBarView for the different sections
          Expanded(
            child: TabBarView(
              children: [
                ChartsView(),
                OrderbookView(),
                RecentTradesView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
