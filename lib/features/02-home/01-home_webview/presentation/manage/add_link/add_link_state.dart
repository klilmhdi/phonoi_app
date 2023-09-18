part of 'add_link_cubit.dart';

@immutable
class AddLinkState extends Equatable {
  final TextEditingController controller;
  final double progressValue;
  final bool isDownloading;
  final List<VideoQualityModel>? qualities;
  final VideoDownloadModel? video;
  final bool isLoading;
  final int selectedQualityIndex;
  final String fileName;
  final bool isSearching;
  final VideoType videoType;
  final String fileType;

  AddLinkState({
    required this.controller,
    required this.progressValue,
    required this.isDownloading,
    required this.qualities,
    required this.video,
    required this.isLoading,
    required this.selectedQualityIndex,
    required this.fileName,
    required this.isSearching,
    required this.videoType,
    required this.fileType,
  });

  factory AddLinkState.initial() {
    return AddLinkState(
      controller: TextEditingController(),
      progressValue: 0.0,
      isDownloading: false,
      qualities: [],
      video: null,
      isLoading: false,
      selectedQualityIndex: 0,
      fileName: '',
      isSearching: false,
      videoType: VideoType.non,
      fileType: ".mp4",
    );
  }

  AddLinkState copyWith({
    TextEditingController? controller,
    double? progressValue,
    bool? isDownloading,
    List<VideoQualityModel>? qualities,
    VideoDownloadModel? video,
    bool? isLoading,
    int? selectedQualityIndex,
    String? fileName,
    bool? isSearching,
    VideoType? videoType,
    String? fileType,
  }) {
    return AddLinkState(
      controller: controller ?? this.controller,
      progressValue: progressValue ?? this.progressValue,
      isDownloading: isDownloading ?? this.isDownloading,
      qualities: qualities ?? this.qualities,
      video: video ?? this.video,
      isLoading: isLoading ?? this.isLoading,
      selectedQualityIndex: selectedQualityIndex ?? this.selectedQualityIndex,
      fileName: fileName ?? this.fileName,
      isSearching: isSearching ?? this.isSearching,
      videoType: videoType ?? this.videoType,
      fileType: fileType ?? this.fileType,
    );
  }

  @override
  List<Object?> get props => [
        controller,
        progressValue,
        isDownloading,
        qualities,
        video,
        isLoading,
        selectedQualityIndex,
        fileName,
        isSearching,
        videoType,
        fileType,
      ];
}
