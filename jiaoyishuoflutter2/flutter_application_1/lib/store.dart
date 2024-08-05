import 'package:redux/redux.dart';

bool counterReducer(bool state, dynamic action) {
  return action['type'] == "mainAnimation" ? action['payload'] : state;
}

final mystore = Store<bool>(counterReducer, initialState: true);