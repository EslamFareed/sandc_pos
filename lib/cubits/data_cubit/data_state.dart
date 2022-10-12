part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}


////////////////////////////////////////////////////

class GetAllClientTableLoading extends DataState {}
class GetAllClientTableSuccess extends DataState {}
class GetAllClientTableError extends DataState {}
