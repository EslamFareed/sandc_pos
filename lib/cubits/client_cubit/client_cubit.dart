import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../online_models/client_response_model.dart';
import '../../reposetories/shared_pref/cache_helper.dart';
import '../../reposetories/shared_pref/cache_keys.dart';
import '../data_cubit/data_cubit.dart';
import 'client_states.dart';

class ClientCubit extends Cubit<ClientStates> {
  ClientCubit() : super(ClientCubitInitialState());

  static ClientCubit get(context) => BlocProvider.of(context);

  List<ClientResponseModel> clients = [];

  void searchClients(String query, BuildContext context) {
    final clientsSearched =
        DataCubit.get(context).clientModels.where((element) {
      final clientName = element.name!.toLowerCase();
      final input = query.toLowerCase();

      return clientName.contains(input);
    });
    clients = clientsSearched.toList();
    emit(SearchClients());
  }
}
