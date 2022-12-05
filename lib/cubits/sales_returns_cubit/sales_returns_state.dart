part of 'sales_returns_cubit.dart';

@immutable
abstract class SalesReturnsState {}

class SalesReportInitial extends SalesReturnsState {}

class GetOrdersForFirstTimeState extends SalesReturnsState {}

class SelectDateFilterState extends SalesReturnsState {}

class FilterOrdersByDateState extends SalesReturnsState {}

class GetOrderDetailsState extends SalesReturnsState {}

class SearchOrderQueryState extends SalesReturnsState {}
