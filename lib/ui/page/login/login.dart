import 'package:flutter/services.dart';
import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/main/main.dart';
import 'package:today/data/state/login.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: NormalTitle("手机号登录"),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) {
          return LoginBloc();
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          condition: (_, current) {
            return current is LoadedSmsCodeState && current.success;
          },
          builder: (_, state) {
            if (state is LoadedSmsCodeState) {
              return _InputSmsCodeWidget();
            }
            return _InputPhoneWidget();
          },
        ),
      ),
    );
  }
}

class _InputPhoneWidget extends StatelessWidget {
  const _InputPhoneWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.primaryPadding),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: AppDimensions.primaryPadding * 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.primaryPadding * 1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: AppColors.dividerGrey,
                )),
            child: Row(
              children: <Widget>[
                Text(
                  '+86',
                  style: TextStyle(color: AppColors.blue),
                ),
                SizedBox(
                  width: AppDimensions.primaryPadding * 1.5,
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: AppColors.dividerGrey,
                ),
                SizedBox(
                  width: AppDimensions.primaryPadding * 1.5,
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return TextField(
                        decoration: InputDecoration(
                            hintText: '输入手机号码', border: InputBorder.none),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                          WhitelistingTextInputFormatter(RegExp(r'\d'))
                        ],
                        onChanged: (text) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(InputPhoneEvent(text));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding * 2,
          ),
          BlocBuilder<LoginBloc, LoginState>(
            condition: (previous, current) {
              return current is InputPhoneState;
            },
            builder: (context, state) {
              VoidCallback onPress;
              if (state is InputPhoneState && state.phone.length == 11) {
                onPress = () {
                  // 获取验证码
                  BlocProvider.of<LoginBloc>(context)
                      .add(FetchSmsCodeEvent(state.phone));
                };
              }

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: RaisedButton(
                      onPressed: onPress,
                      disabledTextColor: Colors.white,
                      color: AppColors.primaryButtonColor,
                      textColor: AppColors.primaryTextColor,
                      disabledColor: AppColors.disableButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.buttonRadius)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.primaryPadding),
                        child: Text('获取验证码'),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class _InputSmsCodeWidget extends StatelessWidget {
  const _InputSmsCodeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.primaryPadding),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: AppDimensions.primaryPadding * 2,
          ),
          BlocBuilder<LoginBloc, LoginState>(
            condition: (_, current) {
              return current is LoadedSmsCodeState && current.success;
            },
            builder: (context, state) {
              return Text(
                '短信验证码已发送至 +86 *******${(state as LoadedSmsCodeState).phone.substring(7)}',
                style: TextStyle(color: AppColors.tipsTextColor, fontSize: 14),
              );
            },
          ),
          SizedBox(
            height: AppDimensions.primaryPadding * 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.primaryPadding * 1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: AppColors.dividerGrey,
                )),
            child: Builder(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(
                      hintText: '输入验证码', border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    WhitelistingTextInputFormatter(RegExp(r'\d'))
                  ],
                  onChanged: (text) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(InputSmsEvent(text));
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding * 2,
          ),
          BlocBuilder<LoginBloc, LoginState>(
            condition: (previous, current) {
              return current is InputSmsState;
            },
            builder: (context, state) {
              VoidCallback onPress;
              if (state is InputSmsState && state.smsCode.length == 6) {
                onPress = () {
                  // 获取验证码
                  BlocProvider.of<LoginBloc>(context)
                      .add(FetchLoginEvent(state.smsCode, context));
                };
              }

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: RaisedButton(
                      onPressed: onPress,
                      disabledTextColor: Colors.white,
                      color: AppColors.primaryButtonColor,
                      textColor: AppColors.primaryTextColor,
                      disabledColor: AppColors.disableButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.buttonRadius)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.primaryPadding),
                        child: Text('验证'),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
