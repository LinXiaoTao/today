import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/model/init.dart';

class MessageModel extends Model {
  Message _message;

  Message get message {
    return _message;
  }

  requestMessageDetail(String id, {String ref}) {}
}
