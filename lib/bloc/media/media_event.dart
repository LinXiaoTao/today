import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MediaEvent extends Equatable {
  MediaEvent([List props = const []]) : super(props);
}

class FetchMediaEvent extends MediaEvent {
  final String id;
  final String type;
  final String trigger;

  FetchMediaEvent(this.id, {this.type = 'ORIGINAL_POST', this.trigger = 'user'})
      : super([id, type, trigger]);

  @override
  String toString() {
    return 'FetchMediaEvent{id: $id, type: $type, trigger: $trigger}';
  }
}
