part of 'files_cubit.dart';

class FilesState {
  final FilesStateStatus status;
  final String? filePath;
  final int musicLength;
  final List<AssetEntity> assetsImage;
  final List<AssetEntity> assetsVideo;
  final Map<DateTime, List<AssetEntity>> assetsByDateInsta;
  final Map<DateTime, List<AssetEntity>> assetsByDateWhatsapp;

  FilesState({
    required this.status,
    required this.filePath,
    required this.musicLength,
    required this.assetsImage,
    required this.assetsVideo,
    required this.assetsByDateInsta,
    required this.assetsByDateWhatsapp,
  });

  factory FilesState.initial() {
    return FilesState(
      status: FilesStateStatus.loading,
      filePath: null,
      musicLength: 0,
      assetsImage: [],
      assetsVideo: [],
      assetsByDateInsta: {},
      assetsByDateWhatsapp: {},
    );
  }

  FilesState copyWith({
    FilesStateStatus? status,
    String? filePath,
    int? musicLength,
    List<AssetEntity>? assetsImage,
    List<AssetEntity>? assetsVideo,
    Map<DateTime, List<AssetEntity>>? assetsByDateInsta,
    Map<DateTime, List<AssetEntity>>? assetsByDateWhatsapp,
  }) {
    return FilesState(
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      musicLength: musicLength ?? this.musicLength,
      assetsImage: assetsImage ?? this.assetsImage,
      assetsVideo: assetsVideo ?? this.assetsVideo,
      assetsByDateInsta: assetsByDateInsta ?? this.assetsByDateInsta,
      assetsByDateWhatsapp: assetsByDateWhatsapp ?? this.assetsByDateWhatsapp,
    );
  }
}
