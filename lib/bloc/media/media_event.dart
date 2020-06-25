import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MediaEvent extends Equatable {
}

class FetchMediaEvent extends MediaEvent {
  final String id;
  final String type;
  final String trigger;

  FetchMediaEvent(this.id, {this.type = 'ORIGINAL_POST', this.trigger = 'user'})
      : super();

  @override
  String toString() {
    return 'FetchMediaEvent{id: $id, type: $type, trigger: $trigger}';
  }

  @override
  List<Object> get props => [id, type, trigger];
}
