import 'package:flutter/material.dart';
import 'package:roqqu/presentation/components/app_bar.dart';
import 'package:roqqu/presentation/components/buttons/buysell_button.dart';
import 'package:roqqu/presentation/views/home/widgets/bottom_sheets/order_bottom_sheet.dart';
import 'package:roqqu/presentation/views/home/widgets/chart_tabs/tab_bar_section.dart';
import 'package:roqqu/presentation/views/home/widgets/order_tabs/order_tabs.dart';
import 'package:roqqu/presentation/views/home/widgets/pair_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Pair Details
          PairDetails(),
          // Charts and Order Book TabBar
          SizedBox(
            height: screenHeight * 0.64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TabBarSection(),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OpenOrdersTabSection(),
          ),
          SizedBox(height: 20),
          // Buy and Sell Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: BuySellButton(
                    label: "Buy",
                    isBuy: true,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => OrderBottomSheet(isBuy: true),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BuySellButton(
                    label: "Sell",
                    isBuy: false,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => OrderBottomSheet(isBuy: false),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
