import 'package:today/ui/ui_base.dart';
import 'package:today/data/repository/message_model.dart';

/// 消息详情
class MessageDetailPage extends StatelessWidget {
  final String id;
  final String ref;
  final MessageModel _messageModel = MessageModel();

  MessageDetailPage({@required this.id, this.ref});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MessageModel>(
      model: _messageModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, Model model) {
          return NormalPage(
            body: null,
            title: NormalTitle('动态详情'),
          );
        },
      ),
    );
  }
}
