import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app-cubit/app_cubit/app_cubit/app_cubit.dart';
import '../../../../../generated/l10n.dart';

class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).select_lang),
        centerTitle: true,
      ),
      body: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.languageCode != current.languageCode,
        builder: (context, state) {
          AppCubit appCubit = BlocProvider.of(context, listen: false);
          return Column(
            children: [
              RadioListTile<String>(
                activeColor: Colors.deepPurple,
                onChanged: (String? value) {
                  appCubit.setLanguage(languageCode: 'en');
                },
                value: state.languageCode,
                groupValue: "en",
                title: Text(S.of(context).engl),
              ),
              RadioListTile<String>(
                activeColor: Colors.deepPurple,
                title: Text(S.of(context).arab),
                value: state.languageCode,
                groupValue: "ar",
                onChanged: (String? value) {
                  appCubit.setLanguage(languageCode: 'ar');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
