import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/core/utils/widgets/games_widegts.dart';
import 'package:phonoi_app/features/02-home/2-games_suggestions/data/games_model.dart';

import '../../../../../generated/l10n.dart';
import '../manage/explorer_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).explore,
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: BlocProvider(
        create: (context) => ExplorerCubit()..fetchGames(),
        child: BlocBuilder<ExplorerCubit, List<Game>>(
          builder: (context, games) {
            ExplorerCubit explorerCubit = ExplorerCubit.get(context);
            if (games.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else if (games.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () => explorerCubit.fetchGames(),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20, crossAxisCount: 3),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return GamesCard(
                      gameName: game.name,
                      gameImage: game.thumbnail,
                    );
                  },
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
