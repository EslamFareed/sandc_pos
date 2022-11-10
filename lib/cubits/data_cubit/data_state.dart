part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

////////////////////////////////////////////////////

class GetAllClientTableLoading extends DataState {}

class GetAllClientTableSuccess extends DataState {}

class GetAllClientTableError extends DataState {}

////////////////////////////////////////////////////

class GetAllProductTableLoading extends DataState {}

class GetAllProductTableSuccess extends DataState {}

class GetAllProductTableError extends DataState {}

////////////////////////////////////////////////////

class GetAllCategoryTableLoading extends DataState {}

class GetAllCategoryTableSuccess extends DataState {}

class GetAllCategoryTableError extends DataState {}

////////////////////////////////////////////////////

class OrderFinishedState extends DataState {}

class InsertClientInSaleScreenState extends DataState {}

class ChangeClientChosenState extends DataState {}

class ChangePayTypeState extends DataState {}

class ChangeIsPayingCashState extends DataState {}

class ChangeSaleAmountState extends DataState {}

class ChangeSaleChosenState extends DataState {}

class SearchProdcutLoading extends DataState {}

class AddQuantityProdcutLoading extends DataState {}

class AddQuantityProdcutSuccess extends DataState {}

class AddNewProductLoading extends DataState {}

class AddNewProductSuccess extends DataState {}

class DeleteProductFromHomeLoading extends DataState {}

class DeleteProductFromHomeSuccess extends DataState {}
