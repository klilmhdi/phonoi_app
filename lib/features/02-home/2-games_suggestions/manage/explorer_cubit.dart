import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:phonoi_app/core/api/games_api.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<List<Map<String, dynamic>>> {
  ExplorerCubit() : super([]);

  static ExplorerCubit get(context) => BlocProvider.of(context, listen: false);

  Future<void> fetchGames() async {
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      emit(data.cast<Map<String, dynamic>>());
    }
  }
}
