import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubits/main_cubit/main_cubit.dart';
import 'build_drop_down_button.dart';

class CurrencySwitch extends StatelessWidget {
  final bool isExpanded;
  final double width;
  const CurrencySwitch({
    Key? key,
    required this.isExpanded,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit.get(context);
    return SizedBox(
      width: width,
      child: DefaultDropDownButton(
        values: const ['USD', 'SAR', 'EGP'],
        dropDownValue: cubit.currency,
        labelText: '',
        isExpanded: isExpanded,
        onChangeFun: (String val) {
          cubit.changeCurrency(context, curn: val);
        },
      ),
    );
  }
}
