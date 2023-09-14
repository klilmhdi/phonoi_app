import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/core/utils/widgets/snackbars_widgets.dart';

import '../../../../generated/l10n.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDownload = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          S.of(context).downloads,
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 15, top: 26, end: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => showSnackBar(S.of(context).we_develop_it, 3, context),
                    child: Container(
                      height: 87,
                      width: 104,
                      decoration: BoxDecoration(color: Color(0xffCAD6FF), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.language,
                            color: Color(0xff8C52FF),
                            size: 56,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            S.of(context).last_website,
                            style: TextStyle(fontSize: 14, color: Color(0xff8C52FF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 26),
            isDownload == true
                ? Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: Colors.grey[100],
                        ),
                        child: ListTile(
                          leading: Container(color: Colors.black87, width: 70.0, height: double.infinity),
                          title: Text("اسم الملف"),
                          subtitle: Text("نوع التنزيل"),
                          trailing: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.0,),
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: 10.0,
                      ),
                    ),
                  )
                : Container(
                    height: 561,
                    width: 346,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black,
                      border: Border.all(
                        color: const Color(0xff9B9B9B),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 95,
                          height: 74,
                          child: Icon(Icons.download, size: 80),
                        ),
                        Text(
                          S.of(context).downloads_is_empty,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
