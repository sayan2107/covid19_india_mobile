import 'package:flutter/material.dart';

/// Every BLOC in this app must extent this class
abstract class BaseBloc {
  void onDispose();
}

Type _typeOf<T>() => T;

class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlockProviderState<T> createState() => _BlockProviderState<T>();

  static T of<T extends BaseBloc>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.bloc;
  }
}

class _BlockProviderState<T extends BaseBloc> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _BlocProviderInherited<T>(
        child: widget.child,
        bloc: widget.bloc,
      ),
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}