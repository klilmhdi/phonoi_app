import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/core/app-cubit/language/language_cubit.dart';
import 'package:phonoi_app/core/enums/language.dart';

class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        bloc: context.read<LanguageCubit>(),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('تحديد اللغة'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                RadioListTile(
                  onChanged: (value) => context.read<LanguageCubit>().switchLanguage(),
                  value: Languages.eg,
                  groupValue: state.isEnglish,
                  title: Text('الإنجليزية'),
                ),
                RadioListTile(
                  title: Text('العربية'),
                    value: Languages.ar,
                    groupValue: state.isEnglish,
                    onChanged: (value) => context.read<LanguageCubit>().switchLanguage(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
