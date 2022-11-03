import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/cubits/client_cubit/client_cubit.dart';
import 'package:sandc_pos/cubits/client_cubit/client_states.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/online_models/client_response_model.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';
import 'package:uuid/uuid.dart';

class SearchCustomersScreen extends StatefulWidget {
  SearchCustomersScreen({Key? key}) : super(key: key);

  @override
  State<SearchCustomersScreen> createState() => _SearchCustomersScreenState();
}

class _SearchCustomersScreenState extends State<SearchCustomersScreen> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    ClientCubit.get(context).clients = DataCubit.get(context).clientModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientStates>(
      builder: (context, state) {
        var cubit = ClientCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Search By name"),
            ),
            body: _buildBody(cubit));
      },
      listener: (context, state) {},
    );
  }

  _buildBody(ClientCubit cubit) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              cubit.searchClients(value, context);
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Clients Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black))),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: cubit.clients.length,
                itemBuilder: (ctx, i) => _buildItemSearch(cubit.clients[i])))
      ],
    );
  }

  _buildItemSearch(ClientResponseModel client) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(client.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("phone : ${client.phone!}"),
            Text("max debit : ${client.maxDebitLimit!}"),
            Text("debit amount : ${client.ammountTobePaid!}"),
          ],
        ),
      ),
    );
  }
}
