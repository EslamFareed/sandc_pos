part of 'data_online_cubit.dart';

@immutable
abstract class DataOnlineState {}

class DataOnlineInitial extends DataOnlineState {}

//!
class GetDataOnlineSuccessState extends DataOnlineState {}

class GetDataOnlineLoadingState extends DataOnlineState {}

class GetDataOnlineErrorState extends DataOnlineState {}

//!
class GetDataOnlineClientsSuccessState extends DataOnlineState {}

class GetDataOnlineClientsLoadingState extends DataOnlineState {}

class GetDataOnlineClientsErrorState extends DataOnlineState {}

//!
class GetDataOnlineProductsSuccessState extends DataOnlineState {}

class GetDataOnlineProductsLoadingState extends DataOnlineState {}

class GetDataOnlineProductsErrorState extends DataOnlineState {}

//!
class GetDataOnlineCategoriesSuccessState extends DataOnlineState {}

class GetDataOnlineCategoriesLoadingState extends DataOnlineState {}

class GetDataOnlineCategoriesErrorState extends DataOnlineState {}

//!
class GetDataOnlinePayTypesSuccessState extends DataOnlineState {}

class GetDataOnlinePayTypesLoadingState extends DataOnlineState {}

class GetDataOnlinePayTypesErrorState extends DataOnlineState {}

//!
class GetDataOnlineOrdersSuccessState extends DataOnlineState {}

class GetDataOnlineOrdersLoadingState extends DataOnlineState {}

class GetDataOnlineOrdersErrorState extends DataOnlineState {}

//!
class GetDataOnlineDebitPayingsSuccessState extends DataOnlineState {}

class GetDataOnlineDebitPayingsLoadingState extends DataOnlineState {}

class GetDataOnlineDebitPayingsErrorState extends DataOnlineState {}

//!
class GetDataOnlineCompanyInfoSuccessState extends DataOnlineState {}

class GetDataOnlineCompanyInfoLoadingState extends DataOnlineState {}

class GetDataOnlineCompanyInfoErrorState extends DataOnlineState {}
