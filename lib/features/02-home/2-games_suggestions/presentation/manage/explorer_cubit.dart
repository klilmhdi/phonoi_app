import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:phonoi_app/core/api/games_api.dart';
import 'package:phonoi_app/features/02-home/2-games_suggestions/data/games_model.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<List<Game>> {
  ExplorerCubit() : super([]);

  static ExplorerCubit get(context) => BlocProvider.of(context, listen: false);

  Future<void> fetchGames() async {
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Game> loadedGames = data.map((game) {
        return Game.fromJson(game);
      }).toList();
      emit(loadedGames);
      // return Game.fromJson(loadedGames);
    } else {
      throw Exception('Failed to load games!!');
    }
  }
}
