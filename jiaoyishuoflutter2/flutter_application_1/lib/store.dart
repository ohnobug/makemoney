import 'package:redux/redux.dart';

class StoreType {
  bool? contactazshow = false;   // 通信录中的 A-Z 是否显示
  bool? mainpage1isload = false; // 页面 1 是否显示
  bool? mainpage2isload = false; // 页面 2 是否显示
  bool? mainpage3isload = false; // 页面 3 是否显示
  bool? mainpage4isload = false; // 页面 4 是否显示

  StoreType({
    this.contactazshow,
    this.mainpage1isload,
    this.mainpage2isload,
    this.mainpage3isload,
    this.mainpage4isload,
  });

  StoreType copyWith({
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
  }) {
    return StoreType(
      contactazshow: contactazshow?? this.contactazshow,
      mainpage1isload: mainpage1isload?? this.mainpage1isload,
      mainpage2isload: mainpage2isload?? this.mainpage2isload,
      mainpage3isload: mainpage3isload?? this.mainpage3isload,
      mainpage4isload: mainpage4isload?? this.mainpage4isload,
    );
  }
}

StoreType counterReducer(StoreType state, dynamic action) {
  if (action['type'] == "contactazshow") {
    return state.copyWith(contactazshow: action['payload']);
  }

  if (action['type'] == "mainpage1isload") {
    return state.copyWith(mainpage1isload: action['payload']);
  }

  if (action['type'] == "mainpage2isload") {
    return state.copyWith(mainpage2isload: action['payload']);
  }

  if (action['type'] == "mainpage3isload") {
    return state.copyWith(mainpage3isload: action['payload']);
  }

  if (action['type'] == "mainpage4isload") {
    return state.copyWith(mainpage4isload: action['payload']);
  }

  return state;
}

final myStore = Store<StoreType>(counterReducer,
    initialState: StoreType(
      contactazshow: false,
      mainpage1isload: false,
      mainpage2isload: false,
      mainpage3isload: false,
      mainpage4isload: false,
    ));
