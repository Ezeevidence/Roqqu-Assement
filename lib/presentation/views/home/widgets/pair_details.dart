import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roqqu/view_model/binance_data_view_model.dart';

import '../../../../utils/color_manager.dart';

class PairDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<BinanceDataViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.currency_bitcoin, color: Colors.orange),
                        SizedBox(width: 4),
                        Text('BTC/USDT', style: TextStyle(fontSize: 16)),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                    Text(
                      viewModel.price != null
                          ? '\$${viewModel.price!.toStringAsFixed(2)}'
                          : 'Loading...',
                      style: const TextStyle(
                        color: ColorManager.greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('24h change'),
                        Text(
                          viewModel.change != null
                              ? '${viewModel.change!.toStringAsFixed(2)}%'
                              : 'Loading...',
                          style: const TextStyle(color: ColorManager.greenColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('24h high'),
                        Text(
                          viewModel.high != null
                              ? '${viewModel.high!.toStringAsFixed(2)}'
                              : 'Loading...',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('24h low'),
                        Text(
                          viewModel.low != null
                              ? '${viewModel.low!.toStringAsFixed(2)}'
                              : 'Loading...',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
    );
  }
}







