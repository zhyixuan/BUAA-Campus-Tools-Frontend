import 'package:flutter/material.dart';
import 'package:jiaowuassistent/pages/User.dart';

class FeedbackDetailPage extends StatefulWidget {
  final String kind;

  FeedbackDetailPage({Key key, @required this.kind}) : super(key: key);

  @override
  _FeedbackDetailPage createState() {
    return _FeedbackDetailPage();
  }
}

class _FeedbackDetailPage extends State<FeedbackDetailPage> {
  String content;
  FocusNode commentNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.kind}问题描述'),
        backgroundColor: Colors.lightBlue,
      ),
      body: GestureDetector(
        onTap: () {
          commentNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: TextField(
                  enabled: true,
                  maxLines: 12,
                  focusNode: commentNode,
                  decoration: InputDecoration(
                    hoverColor: Colors.lightBlue,
                    hintText: '请描述详情',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String str) {
                    content = str;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 50),
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      '提交',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 20,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('确定反馈?'),
                              actions: <Widget>[
                                RaisedButton(
                                  child: Text("发送"),
                                  onPressed: () {
                                    //此处添加向后端的put操作。
                                    Navigator.of(context).pop();
                                    postMessage(widget.kind, content);
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("反馈成功"),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    disabledColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
