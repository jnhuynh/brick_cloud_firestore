import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

class SimpleBlocDelegate extends BlocDelegate {
  Logger logger = new Logger('Bloc');

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logger.finest('onEvent \n bloc: $bloc \n event: $event');
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.finest('onTransition \n bloc: $bloc \n transition: $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    logger.finest(
      '''
      onError
      bloc: ${bloc.state.runtimeType}
      error: $error
      stacktrace: $stacktrace
      ''',
    );
  }
}
