import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phonoi_app/features/02-home/2-games_suggestions/manage/explorer_cubit.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../generated/l10n.dart';

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
      body: BlocBuilder<ExplorerCubit, List<Map<String, dynamic>>>(
        builder: (context, games) {
          ExplorerCubit explorerCubit = BlocProvider.of(context, listen: false);
          if (games.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  title: Text(game['name']),
                  subtitle: Text(game['created_at']),
                );
              },
            );
          }
        },
      ),
    );
  }
}