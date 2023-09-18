import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:phonoi_app/features/02-home/3-files/widgets/music_player/player_controller.dart';

import '../../../../../generated/l10n.dart';
import 'music_player_screen.dart';

class MusicPlayerListScreen extends StatelessWidget {
  const MusicPlayerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          S.of(context).all_music,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.DESC_OR_GREATER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Text(
              S.of(context).no_musics,
              style: TextStyle(),
            );
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Obx(
                    () => ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      dense: true,
                      autofocus: true,
                      // tileColor: Colors.grey.shade300,
                      title: Text(
                        "${snapshot.data![index].title}",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, ),
                      ),
                      subtitle: Text(
                        "${snapshot.data![index].artist}",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, ),
                      ),
                      leading: QueryArtworkWidget(
                        id: snapshot.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.indigo,
                          child: Icon(
                            Icons.music_note,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      trailing: controller.playIndex.value == index && controller.isPlaying.value
                          ? Icon(
                              Icons.play_arrow,
                              size: 26,
                              color: Colors.white,
                            )
                          : null,
                      onTap: () {
                        Get.to(
                            () => MusicPlayer(
                                  data: snapshot.data!,
                                ),
                            transition: Transition.downToUp);
                        controller.playSong(
                          snapshot.data![index].uri,
                          index,
                          snapshot.data![index].album,
                          snapshot.data![index].title,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
