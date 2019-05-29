import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/model/init.dart';
import 'package:today/data/network/request.dart';

class MessageModel extends Model {
  Message _message;
  List<Message> _listRelated = [];

  Message get message {
    return _message;
  }

  List<Message> get listRelated {
    return _listRelated;
  }

  requestMessageDetail(String id, {String ref, String pageName}) async {
    _listRelated.clear();
    _message = await ApiRequest.originalPostsGet(id, userRef: ref);
    _listRelated.addAll(await ApiRequest.listRelated(id, pageName: pageName));
    notifyListeners();
  }
}
