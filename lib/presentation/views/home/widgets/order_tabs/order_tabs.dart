import 'package:flutter/material.dart';
import 'package:roqqu/utils/extensions/theme_extensions.dart';

class OpenOrdersTabSection extends StatelessWidget {
  const OpenOrdersTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDarkMode;

    return  DefaultTabController(
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
            child: TabBar(

              tabs: [
                Tab(text: "Open Orders"),
                Tab(text: "Positions"),
                Tab(text: "Order History"),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: [
                Center(child: Text('No Open Orders')),
                Center(child: Text('No Positions')),
                Center(child: Text('No Order History')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
