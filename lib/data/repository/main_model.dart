import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/model/init.dart';
import 'package:today/data/network/request.dart';
import 'dart:async';

class MainModel extends Model {
  CentralEntry _centralEntry;

  CentralEntry get centralEntry {
    return _centralEntry;
  }

  static MainModel of(BuildContext context, {bool rebuildOnChange = false}) {
    return ScopedModel.of(context, rebuildOnChange: rebuildOnChange);
  }

  /// 发布按钮样式
  requestCentralEntry() async {
    await ApiRequest.profile();
    _centralEntry = await ApiRequest.centralEntry();
    notifyListeners();
  }
}
