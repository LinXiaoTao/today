import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/network/request.dart';

class MediaModel extends Model {
  String _url;

  String get url {
    return _url;
  }

  requestInteractive(String id,
      {String type = 'ORIGINAL_POST', String trigger = 'auto'}) async {
    Map result = await ApiRequest.mediaMeta(
        {'id': id, 'type': type, 'trigger': trigger});

    _url = result['url'];
    notifyListeners();
  }
}
