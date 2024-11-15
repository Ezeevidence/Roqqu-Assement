import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/locator.dart';
import 'base-view-model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T)? onStart;
  const BaseView({this.onStart, required this.builder, Key? key})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  var model = locator<T>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(
          builder: widget.builder,
        ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.onStart != null) {
      widget.onStart!(model);
    }
  }
}
