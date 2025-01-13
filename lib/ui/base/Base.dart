import 'package:chatnow/utils/Dialog_Utils.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoading({String message = 'Loading.....'});

  void hideLoadingDialog();

  void showMessageDialog(
    String massage, {
    String? postActionName,
    VoidCallback? postAction,
    String? negActionName,
    VoidCallback? negAction,
  });
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void showLoading({String message = 'Loading.....'}) {
    DialogUtils.showLoadingDialog(context, message);
  }

  @override
  void hideLoadingDialog() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showMessageDialog(String massage,
      {String? postActionName,
      VoidCallback? postAction,
      String? negActionName,
      VoidCallback? negAction}) {
    DialogUtils.showMessage(
      context,
      massage,
      negActionName: negActionName,
      postActionName: postActionName,
      postAction: postAction,
      negAction: negAction,
    );
  }
}
