import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/enums/video_types.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../data/models/video_downloaded_model.dart';

class VideoQualityCard extends StatelessWidget {
  final VideoQualityModel model;
  final VoidCallback onTap;
  final VideoType type;
  final bool isSelected;

  const VideoQualityCard(
      {Key? key, required this.model, required this.onTap, required this.type, required this.isSelected})
      : super(key: key);

  String? get _quality {
    switch (type) {
      case VideoType.facebook:
        if (model.quality == "hd" || model.quality == "HD") {
          return "High Defination";
        } else {
          return "Standerd Defination ";
        }
      case VideoType.twitter:
        return model.quality;

      case VideoType.youtube:
        return model.quality;

      case VideoType.instagram:
        return model.quality;

      case VideoType.tiktok:
        return model.quality;
      default:
        return null;
    }
  }

  int? get _qualityValue {
    switch (type) {
      case VideoType.facebook:
        if (_quality == "High Defination") {
          return 720;
        } else {
          return 360;
        }
      case VideoType.twitter:
        return int.parse(
          model.quality!.substring(_quality!.indexOf(":") + 1),
        );
      case VideoType.youtube:
        return int.parse(
          model.quality!.substring(_quality!.indexOf(":") + 1),
        );
      case VideoType.instagram:
        return int.parse(
          model.quality!.substring(_quality!.indexOf(":") + 1),
        );
      case VideoType.tiktok:
        return int.parse(
          model.quality!.substring(_quality!.indexOf(":") + 1),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(width: 1, color: CustomColors.primary),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected
                ? Icon(
                    FontAwesomeIcons.checkCircle,
                    color: CustomColors.primary,
                    size: 20.w,
                  )
                : Icon(
                    _qualityValue! < 720 ? Icons.sd : Icons.hd_rounded,
                    color: CustomColors.primary,
                    size: 28.w,
                  ),
            SizedBox(width: 5.w),
            Text(
              (type == VideoType.youtube || type == VideoType.twitter || type == VideoType.tiktok)
                  ? "${_qualityValue}P"
                  : _quality!,
              style: TextStyle(
                fontSize: 20,
                color: CustomColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
