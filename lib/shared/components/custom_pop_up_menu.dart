import 'package:flutter/material.dart';

class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
  final Widget childWidget;
  final Function onClick;
  MyPopUpMenuItem({Key? key, required this.childWidget, required this.onClick})
      : super(key: key, child: childWidget, onTap: () => onClick());

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopUpMenuItemState();
  }
}

class MyPopUpMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
