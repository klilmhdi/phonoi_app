import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:phonoi_app/features/02-home/3-files/widgets/music_player/player_controller.dart';

class MusicPlayer extends StatelessWidget {
  final List<SongModel> data;

  MusicPlayer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Colors.indigo.shade900,
              Colors.indigo.shade400,
              Colors.pinkAccent.shade100,
            ])),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'الموسيقى',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 20),
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 300,
                          width: 340,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                              Colors.pinkAccent.shade100,
                              Colors.indigo.shade300,
                              Colors.indigo.shade900,
                            ]),
                            // color: Colors.purple,
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          alignment: Alignment.center,
                          child: QueryArtworkWidget(
                            id: data[controller.playIndex.value].id,
                            type: ArtworkType.AUDIO,
                            artworkHeight: double.infinity,
                            artworkWidth: double.infinity,
                            nullArtworkWidget: Icon(
                              Icons.music_note,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Obx(
                      () => Column(
                        children: [
                          Text(
                            data[controller.playIndex.value].title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            data[controller.playIndex.value].artist.toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 35),
                          Obx(
                            () => Column(
                              children: [
                                Slider(
                                  thumbColor: Colors.indigo,
                                  inactiveColor: Colors.white,
                                  activeColor: Colors.indigo.shade400,
                                  min: Duration(seconds: 0).inSeconds.toDouble(),
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  onChanged: (newValue) {
                                    controller.changeDurationToSecond(newValue.toInt());
                                    newValue = newValue;
                                  },
                                ),
                                // SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.position.value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        controller.duration.value,
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.playSong(
                                    data[controller.playIndex.value - 1].uri,
                                    controller.playIndex.value - 1,
                                    data[controller.playIndex.value - 1].album,
                                    data[controller.playIndex.value - 1].title,
                                  );
                                },
                                icon: Icon(
                                  Icons.skip_previous_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Obx(
                                () => CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.indigo,
                                  child: Transform.scale(
                                    scale: 2.5,
                                    child: IconButton(
                                        onPressed: () {
                                          if (controller.isPlaying.value) {
                                            controller.audioPlayer.pause();
                                            controller.isPlaying(false);
                                          } else {
                                            controller.audioPlayer.play();
                                            controller.isPlaying(true);
                                          }
                                        },
                                        icon: controller.isPlaying.value
                                            ? Icon(
                                                Icons.pause,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                              )),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.playSong(
                                    data[controller.playIndex.value + 1].uri,
                                    controller.playIndex.value + 1,
                                    data[controller.playIndex.value + 1].album,
                                    data[controller.playIndex.value + 1].title,
                                  );
                                },
                                icon: Icon(
                                  Icons.skip_next_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
