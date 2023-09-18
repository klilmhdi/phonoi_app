import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(isEnglish: false));

  static LanguageCubit get(context) => BlocProvider.of(context);

  void switchLanguage() {
    emit(LanguageState(isEnglish: !state.isEnglish));
  }
}
