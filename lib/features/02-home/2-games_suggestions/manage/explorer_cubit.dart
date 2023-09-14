import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<ExplorerState> {
  ExplorerCubit() : super(ExplorerInitial());

  static ExplorerCubit get(context) => BlocProvider.of(context, listen: false);

  Future<void> checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    /// I should do thing , I don't what is it ;)
      emit(state);
    } else {
      checkPermission();
    }
  }
}
