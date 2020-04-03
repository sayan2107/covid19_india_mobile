import 'dart:async';

import 'package:flutter/material.dart';

class EventListener<D> extends StatefulWidget {
  final Stream<D> _stream;
  final Function(D event) _onData;
  final Widget child;

  EventListener(this._stream, this._onData, {this.child});

  @override
  _EventListenerState createState() => _EventListenerState<D>();
}

class _EventListenerState<T> extends State<EventListener<T>> {
  StreamSubscription<T> _streamSubscription;

  void _subscribeToStream() {
    _streamSubscription = widget._stream.listen((aData) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget?._onData?.call(aData);
      });
    });
  }

  void _unSubscribeToStream() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  @override
  void initState() {
    _subscribeToStream();
    super.initState();
  }

  @override
  void didUpdateWidget(EventListener<T> oldWidget) {
    if(oldWidget._stream != widget._stream) {
      _unSubscribeToStream();
      _subscribeToStream();
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _unSubscribeToStream();
    super.dispose();
  }
}
