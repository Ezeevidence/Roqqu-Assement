import 'package:flutter/material.dart';
import 'package:roqqu/presentation/components/buttons/gradient_button.dart';
import 'package:roqqu/presentation/components/text_fields/bottom_sheet_text_fields.dart';
import 'package:roqqu/utils/color_manager.dart';
import 'package:roqqu/utils/extensions/theme_extensions.dart';

class OrderBottomSheet extends StatefulWidget {
  bool isBuy;
  OrderBottomSheet({required this.isBuy, Key? key}) : super(key: key);

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDarkMode;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDarkMode? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => widget.isBuy = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: widget.isBuy ? Theme.of(context).cardColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border:widget.isBuy ?  Border.all(color: ColorManager.greenColor, width: 1): null,
                            ),
                            child: const Center(
                              child: Text(
                                "Buy",
                                style: TextStyle(

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => widget.isBuy = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: !widget.isBuy ? Theme.of(context).cardColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border:!widget.isBuy ?  Border.all(color: ColorManager.greenColor, width: 1): null,

                            ),
                            child: const Center(
                              child: Text(
                                "Sell",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Order type tabs
              TabBar(
                controller: _tabController,
                // labelColor: Colors.black,
                // unselectedLabelColor: Colors.grey,
                // labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                // indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                tabs: const [
                  Tab(text: "Limit"),
                  Tab(text: "Market"),
                  Tab(text: "Stop-Limit"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    OrderFormContent(isBuy: widget.isBuy, orderType: "Limit"),
                    OrderFormContent(isBuy: widget.isBuy, orderType: "Market"),
                    OrderFormContent(isBuy: widget.isBuy, orderType: "Stop-Limit"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OrderFormContent extends StatelessWidget {
  final bool isBuy;
  final String orderType;

  const OrderFormContent({
    required this.isBuy,
    required this.orderType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (orderType != "Market") ...[
            ReOrderTextField(prefix: "Limit Price", suffix: "  USD",
            showInfoIcon: true,),
            const SizedBox(height: 16),
          ],
          ReOrderTextField(prefix: "Amount", suffix: "  USD",
            showInfoIcon: true,),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReOrderTextField(
                isDropdown: true,
                prefix: "Type",
                showInfoIcon: true,),
              const SizedBox(height: 8),
            ],
          ),
          if (orderType == "Limit") ...[
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: false,
                    onChanged: (value) {},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Post Only",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
              ],
            ),
          ],
          const SizedBox(height: 16),
          ReOrderTextField(
            prefix: "Price", suffix: "  USD",
            showInfoIcon: true,),

          const SizedBox(height: 24),
          GradientButton(
            text:    "${isBuy ? 'Buy' : 'Sell'} BTC",
            onPressed: () {  },

          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total account value",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    "NGN",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0.00", style: TextStyle(fontSize: 14)),
                Text("Open Orders", style: TextStyle(fontSize: 14)),
                Text("Available: 0.00", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Deposit",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTextField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? suffix;
  final bool enabled;

  const OrderTextField({
    required this.label,
    required this.hint,
    this.suffix,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (suffix != null) ...[
              const SizedBox(width: 4),
              suffix!,
            ],
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600]),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}