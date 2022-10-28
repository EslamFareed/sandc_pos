part of 'data_online_cubit.dart';

@immutable
abstract class DataOnlineState {}

class DataOnlineInitial extends DataOnlineState {}

////////////////////////////////////////
class GetDataOnlineSuccessState extends DataOnlineState {}

class GetDataOnlineLoadingState extends DataOnlineState {}

class GetDataOnlineErrorState extends DataOnlineState {}
