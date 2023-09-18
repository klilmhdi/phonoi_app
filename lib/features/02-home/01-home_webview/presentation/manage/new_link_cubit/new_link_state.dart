part of 'new_link_cubit.dart';

class NewLinkState extends Equatable {
  final String linkContent;
  final RequestState videoLoadingState;
  final int selectedQualityIndex;
  final String fileName;
  final RequestState searchState;
  final VideoType videoType;
  final FileType fileType;
  final double progressValue;
  final RequestState downloadingState;
  final VideoDownloadModel videoDownloadModel;
  final List<VideoQualityModel> qualities;

  const NewLinkState({
    this.linkContent = "",
    this.videoLoadingState = RequestState.initial,
    this.selectedQualityIndex = 1080,
    this.fileName = "Download",
    this.searchState = RequestState.initial,
    this.videoType = VideoType.non,
    this.fileType = FileType.mp4,
    this.progressValue = 0.0,
    this.downloadingState = RequestState.initial,
    this.videoDownloadModel = const VideoDownloadModel(
      createdAt: null,
      title: "",
      source: "",
      thumbnail: "",
      videos: [],
    ),
    this.qualities = const [],
  });

  @override
  List<Object> get props => [
        linkContent,
        videoLoadingState,
        selectedQualityIndex,
        fileName,
        searchState,
        videoType,
        fileType,
        progressValue,
        downloadingState,
        videoDownloadModel,
        qualities,
      ];

  NewLinkState copyWith({
    String? linkContent,
    RequestState? videoLoadingState,
    int? selectedQualityIndex,
    String? fileName,
    RequestState? searchState,
    VideoType? videoType,
    FileType? fileType,
    double? progressValue,
    RequestState? downloadingState,
    VideoDownloadModel? videoDownloadModel,
    List<VideoQualityModel>? qualities,
  }) {
    return NewLinkState(
      linkContent: linkContent ?? this.linkContent,
      videoLoadingState: videoLoadingState ?? this.videoLoadingState,
      selectedQualityIndex: selectedQualityIndex ?? this.selectedQualityIndex,
      fileName: fileName ?? this.fileName,
      searchState: searchState ?? this.searchState,
      videoType: videoType ?? this.videoType,
      fileType: fileType ?? this.fileType,
      progressValue: progressValue ?? this.progressValue,
      downloadingState: downloadingState ?? this.downloadingState,
      videoDownloadModel: videoDownloadModel ?? this.videoDownloadModel,
      qualities: qualities ?? this.qualities,
    );
  }
}
