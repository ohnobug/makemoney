import 'package:bloc/bloc.dart';
import 'package:jiaoyishuoflutter3/logger.dart';

class CounterObserver extends BlocObserver {
  const CounterObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    logger.info('${bloc.runtimeType} $change');
  }
}
