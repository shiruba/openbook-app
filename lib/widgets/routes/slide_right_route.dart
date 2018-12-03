import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OBSlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  final Widget navigationBar;
  final Key key;
  OBSlideRightRoute({this.widget, this.navigationBar, this.key})
      : super(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Material(
            color: Color.fromARGB(0, 0, 0, 0),
            child: Dismissible(
                background: Container(color: Color.fromARGB(0, 0, 0, 0)),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  Navigator.pop(context);
                },
                key: key,
                child: CupertinoPageScaffold(
                    backgroundColor: Color.fromARGB(0, 0, 0, 0),
                    navigationBar: navigationBar,
                    child: Container(
                        color: Colors.white,
                        child: widget
                    )
                )
            )
        );
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child
        );
      }
  );
}