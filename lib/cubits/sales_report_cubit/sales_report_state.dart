part of 'sales_report_cubit.dart';

@immutable
abstract class SalesReportState {}

class SalesReportInitial extends SalesReportState {}

class GetOrdersForFirstTimeState extends SalesReportState {}

class SelectDateFilterState extends SalesReportState {}

class FilterOrdersByDateState extends SalesReportState {}

class GetOrderDetailsState extends SalesReportState {}

class SearchOrderQueryState extends SalesReportState {}
