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
    return BlocProvider(
      create: (context) => ExplorerCubit(),
      child: BlocBuilder<ExplorerCubit, ExplorerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).explore,
                style: TextStyle(fontSize: 22),
              ),
            ),
            // body: SafeArea(
            //   child: Container(
            //     child: Padding(
            //       padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
            //       child: Directionality(
            //         textDirection: TextDirection.rtl,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 135,
            //               width: 347,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(15),
            //                 color: Colors.red.shade50,
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsetsDirectional.only(start: 10),
            //                     child: Row(
            //                       // mainAxisSize: MainAxisSize.min,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Padding(
            //                           padding: EdgeInsetsDirectional.only(top: 10, start: 5),
            //                           child: Text(
            //                             S.of(context).music,
            //                             style: TextStyle(
            //                               color: Colors.red.shade500,
            //                               fontSize: 16,
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                           ),
            //                         ),
            //                         const SizedBox(width: 165),
            //                         Padding(
            //                           padding: const EdgeInsetsDirectional.only(top: 17),
            //                           child: GestureDetector(
            //                             onTap: () async {
            //                               var perm = await Permission.storage.request();
            //                               if (perm.isGranted) {
            //                                 Get.to(
            //                                   () => MusicPlayerListScreen(),
            //                                   // transition: Transition.rightToLeft,
            //                                 );
            //                               } else {
            //                                 // checkPermission();
            //                               }
            //                             },
            //                             child: Container(
            //                               height: 17,
            //                               width: 65,
            //                               decoration: BoxDecoration(
            //                                   color: Colors.red.shade500, borderRadius: BorderRadius.circular(8)),
            //                               child: Row(
            //                                 children: [
            //                                   // SizedBox(width: 2),
            //                                   Padding(
            //                                     padding: EdgeInsetsDirectional.only(start: 3),
            //                                     child: Text(
            //                                       "جميع الأغاني",
            //                                       style: TextStyle(
            //                                           fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold),
            //                                     ),
            //                                   ),
            //                                   SizedBox(width: 5),
            //                                   Icon(
            //                                     Icons.arrow_forward_ios,
            //                                     size: 12,
            //                                     color: Colors.white,
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         IconButton(
            //                             onPressed: () {},
            //                             style: IconButton.styleFrom(maximumSize: Size.zero),
            //                             icon: const Icon(
            //                               Icons.more_vert,
            //                               color: Colors.red,
            //                             ))
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsetsDirectional.symmetric(
            //                       horizontal: 10,
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         GestureDetector(
            //                           onTap: () async {
            //                             var perm = await Permission.storage.request();
            //                             if (perm.isGranted) {
            //                               Get.to(
            //                                 () => MusicPlayerListScreen(),
            //                               );
            //                             } else {
            //                               // checkPermission();
            //                             }
            //                           },
            //                           child: Stack(children: [
            //                             SizedBox(
            //                               height: 79,
            //                               width: 74,
            //                               child: Image.asset('assets/icons/music.png'),
            //                             ),
            //                             Padding(
            //                               padding: EdgeInsetsDirectional.only(start: 10),
            //                               child: Text(
            //                                 "اضغط \nللتشغيل",
            //                                 style: TextStyle(
            //                                   color: Colors.white,
            //                                   fontSize: 11,
            //                                 ),
            //                               ),
            //                             )
            //                           ]),
            //                         ),
            //                         const SizedBox(width: 8),
            //                         Container(
            //                           height: 79,
            //                           width: 241,
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(14),
            //                             color: Colors.white,
            //                           ),
            //                           child: Column(
            //                             children: [
            //                               Padding(
            //                                 padding: EdgeInsetsDirectional.only(top: 10),
            //                                 child: Text(
            //                                   'السماح بالوصول للملفات الموسيقى الخاصة بك',
            //                                   style: TextStyle(
            //                                     color: Color(0xff7D7D7D),
            //                                     fontSize: 11,
            //                                   ),
            //                                 ),
            //                               ),
            //                               ElevatedButton(
            //                                 onPressed: () {
            //                                   // showBottomSheetDialog();
            //                                 },
            //                                 style: ElevatedButton.styleFrom(
            //                                   minimumSize: const Size(92, 22),
            //                                   backgroundColor: const Color(0xff8C52FF),
            //                                   shape: RoundedRectangleBorder(
            //                                     borderRadius: BorderRadius.circular(11),
            //                                   ),
            //                                 ),
            //                                 child: Text(
            //                                   'السماح',
            //                                   style: TextStyle(
            //                                     fontSize: 11,
            //                                     color: Colors.white,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(height: 15),
            //
            //             /// هنا حتنحط الألعاب
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
