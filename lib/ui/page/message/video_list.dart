import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/video_player.dart';
import 'package:today/ui/message.dart';
import 'package:intl/intl.dart' as intl;

final intl.DateFormat _dateFormat = intl.DateFormat('MM/dd HH:mm');

class VideoListPage extends StatefulWidget {
  final Message message;

  VideoListPage(this.message);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage>
    with AfterLayoutMixin<VideoListPage> {
  final VideoListBloc _videoListBloc = VideoListBloc();

  @override
  void afterFirstLayout(BuildContext context) {
    _videoListBloc.dispatch(FetchVideoListEvent(widget.message));
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
        needAppBar: false,
        backgroundColor: Colors.black,
        body: BlocBuilder(
            bloc: _videoListBloc,
            builder: (_, VideoListState state) {
              if (state is LoadedVideoListState) {
                return PageView.builder(
                  itemBuilder: (_, index) {
                    return Stack(
                      children: <Widget>[
                        VideoPlayerPage(id: state.items[index].id),
                        Align(
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top),
                              child: SizedBox(
                                height: 55,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              AppDimensions.primaryPadding * 2),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                    AvatarWidget(state.items[index].user),
                                    SizedBox(
                                      width: AppDimensions.smallPadding,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ScreenNameWidget(
                                              user: state.items[index].user,
                                              textColor: Colors.white,
                                              fontSize: 13,
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.smallPadding,
                                            ),
                                            Text(
                                              _dateFormat.format(DateTime.parse(
                                                  state
                                                      .items[index].createdAt)),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: state.items.length,
                  scrollDirection: Axis.vertical,
                );
              }

              return Center(child: PageLoadingWidget());
            }));
  }
}
