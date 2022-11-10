import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit() : super(SalesInitial());

  static SalesCubit get(context) => BlocProvider.of(context);
}
