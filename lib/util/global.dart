import 'package:flutter/widgets.dart';
import 'package:event_bus/event_bus.dart';

class Global {
  Global._();

  static BuildContext context;

  static final EventBus eventBus = EventBus();
}
