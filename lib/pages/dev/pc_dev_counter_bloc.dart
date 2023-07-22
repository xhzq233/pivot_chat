import 'package:flutter_bloc/flutter_bloc.dart';

class PCDevBloc extends Cubit<int> {
  PCDevBloc({int? initial}) : super(initial ?? 0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
