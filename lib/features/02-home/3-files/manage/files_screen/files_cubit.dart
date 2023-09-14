import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/enums/files_status.dart';

part 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(FilesState.initial());

  static FilesCubit get(context) => BlocProvider.of(context);

  String? filePath;
  OnAudioQuery onAudioQuery = OnAudioQuery();
  late var musicLength = 0;
  List<AssetEntity> assetsImage = [];
  List<AssetEntity> assetsVideo = [];
  Map<DateTime, List<AssetEntity>> assetsByDateInsta = {};
  Map<DateTime, List<AssetEntity>> assetsByDateWhatsapp = {};

  // void fetchMusic() async {
  //   final audioFiles = await onAudioQuery.querySongs();
  //   final numberOfAudioFiles = audioFiles.length;
  //   musicLength = numberOfAudioFiles;
  //   print('Number of audio files: $numberOfAudioFiles');
  // }
  //
  // fetchAssets() async {
  //   final albums = await PhotoManager.getAssetPathList(onlyAll: false, type: RequestType.image);
  //   final recentAlbum = albums.first;
  //   final recentAssets =
  //       await recentAlbum.getAssetListRange(start: 0, end: 100000); // Get 100 assets, increase the end for more.
  //   if (mounted) {
  //     setState(() {
  //       assetsImage = recentAssets;
  //     });
  //   }
  // }
  //
  // fetchAssetsVideo() async {
  //   final albums = await PhotoManager.getAssetPathList(onlyAll: false, type: RequestType.video);
  //   final recentAlbum = albums.first;
  //   final recentAssets =
  //       await recentAlbum.getAssetListRange(start: 0, end: 100000); // Get 100 assets, increase the end for more.
  //   if (mounted) {
  //     setState(() {
  //       assetsVideo = recentAssets;
  //     });
  //   }
  // }
  //
  // checkPermission() async {
  //   var perm = await Permission.storage.request();
  //   if (perm.isGranted) {
  //   } else {
  //     checkPermission();
  //   }
  // }
  //
  // fetchAssetsInsta() async {
  //   final albums = await PhotoManager.getAssetPathList(
  //     onlyAll: false,
  //     type: RequestType.image,
  //   );
  //
  //   Map<DateTime, List<AssetEntity>> tempAssetsByDate = {};
  //
  //   for (var album in albums) {
  //     final assets = await album.getAssetListRange(
  //       start: 0,
  //       end: 100000,
  //     );
  //
  //     for (var asset in assets) {
  //       // تحقق مما إذا كانت الصورة من Instagram
  //       if (asset.relativePath!.toLowerCase().contains('instagram')) {
  //         final dateTime = asset.createDateTime ?? DateTime.now();
  //         final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
  //
  //         // Check if the date is already in the map, if not, create a new list
  //         if (!tempAssetsByDate.containsKey(dateOnly)) {
  //           tempAssetsByDate[dateOnly] = [];
  //         }
  //
  //         // Add the asset to the list corresponding to its capture date
  //         tempAssetsByDate[dateOnly]!.add(asset);
  //       }
  //     }
  //   }
  //
  //   if (mounted) {
  //     setState(() {
  //       assetsByDateInsta = tempAssetsByDate;
  //     });
  //   }
  // }
  //
  // fetchAssetsWhatsapp() async {
  //   final albums = await PhotoManager.getAssetPathList(
  //     onlyAll: false,
  //     type: RequestType.image,
  //   );
  //
  //   Map<DateTime, List<AssetEntity>> tempAssetsByDate = {};
  //
  //   for (var album in albums) {
  //     final assets = await album.getAssetListRange(
  //       start: 0,
  //       end: 100000,
  //     );
  //
  //     for (var asset in assets) {
  //       // تحقق مما إذا كانت الصورة من Instagram
  //       if (asset.relativePath!.toLowerCase().contains('whatsapp')) {
  //         final dateTime = asset.createDateTime ?? DateTime.now();
  //         final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
  //
  //         // Check if the date is already in the map, if not, create a new list
  //         if (!tempAssetsByDate.containsKey(dateOnly)) {
  //           tempAssetsByDate[dateOnly] = [];
  //         }
  //
  //         // Add the asset to the list corresponding to its capture date
  //         tempAssetsByDate[dateOnly]!.add(asset);
  //       }
  //     }
  //   }
  //
  //   if (mounted) {
  //     setState(() {
  //       assetsByDateWhatsapp = tempAssetsByDate;
  //     });
  //   }
  // }
  //
  // void pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc', 'xls', 'ppt', 'txt', 'epub', 'xlsx'],
  //   );
  //
  //   if (result != null) {
  //     print("&*&&&&&&&&&&&&***************${result}");
  //     setState(() {
  //       filePath = result.files.single.path;
  //     });
  //
  //     if (filePath != null) {
  //       OpenFile.open(filePath!);
  //     }
  //   }
  // }
  //
  // void pickFileApk() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['apk'],
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       filePath = result.files.single.path;
  //     });
  //
  //     if (filePath != null) {
  //       OpenFile.open(filePath!);
  //     }
  //   }
  // }

  void fetchMusic() async {
    try {
      final audioFiles = await onAudioQuery.querySongs();
      final numberOfAudioFiles = audioFiles.length;

      emit(state.copyWith(musicLength: numberOfAudioFiles));
    } catch (e) {
      // Handle errors if needed
    }
  }

  void fetchAssets() async {
    try {
      final albums = await PhotoManager.getAssetPathList(onlyAll: false, type: RequestType.image);
      final recentAlbum = albums.first;
      final recentAssets =
          await recentAlbum.getAssetListRange(start: 0, end: 100000); // Get 100 assets, increase the end for more.

      emit(state.copyWith(assetsImage: recentAssets));
    } catch (e) {
      // Handle errors if needed
    }
  }

  void fetchAssetsVideo() async {
    try {
      final albums = await PhotoManager.getAssetPathList(onlyAll: false, type: RequestType.video);
      final recentAlbum = albums.first;
      final recentAssets =
          await recentAlbum.getAssetListRange(start: 0, end: 100000); // Get 100 assets, increase the end for more.

      emit(state.copyWith(assetsVideo: recentAssets));
    } catch (e) {
      // Handle errors if needed
    }
  }

  void checkPermission() async {
    try {
      var perm = await Permission.storage.request();
      if (perm.isGranted) {
      } else {
        checkPermission();
      }
      // Handle permission result if needed
    } catch (e) {
      // Handle errors if needed
    }
  }

  void pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'xls', 'ppt', 'txt', 'epub', 'xlsx'],
      );

      if (result != null) {
        emit(state.copyWith(filePath: result.files.single.path));
      }
    } catch (e) {
      // Handle errors if needed
    }
  }

  void pickFileApk() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['apk'],
      );

      if (result != null) {
        emit(state.copyWith(filePath: result.files.single.path));
      }
    } catch (e) {
      // Handle errors if needed
    }
  }

  void fetchAssetsInsta() async {
    try {
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: false,
        type: RequestType.image,
      );

      Map<DateTime, List<AssetEntity>> tempAssetsByDate = {};

      for (var album in albums) {
        final assets = await album.getAssetListRange(
          start: 0,
          end: 100000,
        );

        for (var asset in assets) {
          // Check if the image is from Instagram
          if (asset.relativePath!.toLowerCase().contains('instagram')) {
            final dateTime = asset.createDateTime ?? DateTime.now();
            final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

            // Check if the date is already in the map, if not, create a new list
            if (!tempAssetsByDate.containsKey(dateOnly)) {
              tempAssetsByDate[dateOnly] = [];
            }

            // Add the asset to the list corresponding to its capture date
            tempAssetsByDate[dateOnly]!.add(asset);
          }
        }
      }

      emit(state.copyWith(assetsByDateInsta: tempAssetsByDate));
    } catch (e) {
      // Handle errors if needed
    }
  }

  void fetchAssetsWhatsapp() async {
    try {
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: false,
        type: RequestType.image,
      );

      Map<DateTime, List<AssetEntity>> tempAssetsByDate = {};

      for (var album in albums) {
        final assets = await album.getAssetListRange(
          start: 0,
          end: 100000,
        );

        for (var asset in assets) {
          // Check if the image is from WhatsApp
          if (asset.relativePath!.toLowerCase().contains('whatsapp')) {
            final dateTime = asset.createDateTime ?? DateTime.now();
            final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

            // Check if the date is already in the map, if not, create a new list
            if (!tempAssetsByDate.containsKey(dateOnly)) {
              tempAssetsByDate[dateOnly] = [];
            }

            // Add the asset to the list corresponding to its capture date
            tempAssetsByDate[dateOnly]!.add(asset);
          }
        }
      }

      emit(state.copyWith(assetsByDateWhatsapp: tempAssetsByDate));
    } catch (e) {
      // Handle errors if needed
    }
  }
}
