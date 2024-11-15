import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../view_model/binance_data_view_model.dart';

class OrderbookView extends StatefulWidget {
  @override
  _OrderbookViewState createState() => _OrderbookViewState();
}

class _OrderbookViewState extends State<OrderbookView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Adding a post frame callback to ensure the widget tree is built before setting scroll position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // Set initial position to roughly center of the list
        double initialScrollOffset = _scrollController.position.maxScrollExtent / 2;
        _scrollController.jumpTo(initialScrollOffset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BinanceDataViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            // Top Row for filtering and visualization buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.sort, color: Colors.grey.shade800),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.sort_by_alpha, color: Colors.grey.shade800),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.tune, color: Colors.grey.shade800),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  DropdownButton<int>(
                    value: 10,
                    items: [10, 20, 50, 100].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {},
                    underline: Container(), // Remove underline
                  ),
                ],
              ),
            ),
            // Column titles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Price (USDT)",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Amounts (BTC)",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Total",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            // Order List
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  OrderbookListWidget(orders: viewModel.asks, isBid: false),
                  CenterValueWidget(price: viewModel.price ?? 0.0),
                  OrderbookListWidget(orders: viewModel.bids, isBid: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CenterValueWidget extends StatelessWidget {
  final double price;

  const CenterValueWidget({required this.price});

  @override
  Widget build(BuildContext context) {
    final Color priceColor = price > 0 ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            price.toStringAsFixed(2),
            style: TextStyle(
              color: priceColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            price > 0 ? Icons.arrow_upward : Icons.arrow_downward,
            color: priceColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class OrderbookListWidget extends StatelessWidget {
  final List<List<dynamic>> orders;
  final bool isBid;

  const OrderbookListWidget({required this.orders, required this.isBid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orders.map((order) {
        final price = double.parse(order[0].toString());
        final amount = double.parse(order[1].toString());
        final total = price * amount;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  price.toStringAsFixed(2),
                  style: TextStyle(
                    color: isBid ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      color: isBid ? Color(0xFF25C26E) : Color(0xFFF6838),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          amount.toStringAsFixed(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  total.toStringAsFixed(2),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
