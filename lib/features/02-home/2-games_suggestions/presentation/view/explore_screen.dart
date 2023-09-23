import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:phonoi_app/core/utils/widgets/games_widegts.dart';
import 'package:phonoi_app/features/02-home/2-games_suggestions/data/games_model.dart';

import '../../../../../generated/l10n.dart';
import '../manage/explorer_cubit.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple,));
            } else if (games.isNotEmpty) {
              return RefreshIndicator(
                color: Colors.deepPurple,
                onRefresh: () => explorerCubit.fetchGames(),
                child: AnimationLimiter(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3 / 2, crossAxisSpacing: 0.7, mainAxisSpacing: 0.7, crossAxisCount: 3),
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GamesCard(
                              gameName: game.name,
                              gameImage: game.thumbnail,
                              gameLink: Platform.isAndroid ? game.googlePlayLink : game.appStoreLink,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator(color: Colors.deepPurple, backgroundColor: Colors.white ,));
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
