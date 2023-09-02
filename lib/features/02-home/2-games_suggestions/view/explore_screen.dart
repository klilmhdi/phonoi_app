import 'package:flutter/material.dart';
import '../widgets/bottom_sheet_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'استكشف',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Container(
                      height: 62,
                      width: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Row(
                          children: [
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '3.4GB',
                                  style: TextStyle(color: Color(0xffFF0000), fontSize: 18),
                                ),
                                Text(
                                  'ملفات مهملة',
                                  style: TextStyle(color: Color(0xffFF0000), fontSize: 8),
                                ),
                              ],
                            ),
                            const SizedBox(width: 57),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/icons/trash.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 62,
                      width: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Row(
                          children: [
                            const Text(
                              'حافظة الحالات',
                              style: TextStyle(color: Color(0xff178500), fontSize: 15),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/icons/whatsapp.png'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 17),
                Container(
                  height: 135,
                  width: 347,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الموسيقى',
                              style: TextStyle(color: Colors.red.shade500, fontSize: 16),
                            ),
                            const SizedBox(width: 175),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 15),
                              child: Container(
                                height: 13,
                                width: 57,
                                decoration:
                                    BoxDecoration(color: Colors.red.shade300, borderRadius: BorderRadius.circular(8)),
                                child: const Row(
                                  children: [
                                    // SizedBox(width: 2),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: 3),
                                      child: Text(
                                        "جميع الأغاني",
                                        style: TextStyle(fontSize: 7),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Stack(children: [
                              SizedBox(
                                height: 79,
                                width: 74,
                                child: Image.asset('assets/icons/music.png'),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.only(start: 10),
                                child: Text(
                                  "اضغط \nللتشغيل",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              )
                            ]),
                            const SizedBox(width: 8),
                            Container(
                              height: 79,
                              width: 241,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.only(top: 10),
                                    child: Text(
                                      'السماح بالوصول للملفات الموسيقى الخاصة بك',
                                      style: TextStyle(
                                        color: Color(0xff7D7D7D),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showBottomSheetDialog(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(92, 22),
                                      backgroundColor: const Color(0xff8C52FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    ),
                                    child: const Text(
                                      'السماح',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                /// هنا حتنحط الألعاب
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: Colors.purple.shade100,
                //   ),
                //   height: 390,
                //   width: 347,
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           children: [
                //             Text(
                //               'ألعاب مصغرة',
                //               style: TextStyle(color: Colors.purple.shade500, fontSize: 19),
                //             ),
                //             const SizedBox(width: 145),
                //             Container(
                //               height: 13,
                //               width: 48,
                //               decoration:
                //                   BoxDecoration(color: Colors.purple.shade500, borderRadius: BorderRadius.circular(8)),
                //               child: const Row(
                //                 children: [
                //                   SizedBox(width: 4),
                //                   Text(
                //                     "المزيد",
                //                     style: TextStyle(fontSize: 8),
                //                   ),
                //                   SizedBox(width: 10),
                //                   Icon(
                //                     Icons.arrow_forward_ios,
                //                     size: 12,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
                //           ],
                //         ),
                //       ),
                //       const Padding(
                //         padding: EdgeInsetsDirectional.symmetric(horizontal: 33),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Games(),
                //             Games(),
                //             Games(),
                //             Games(),
                //           ],
                //         ),
                //       ),
                //       const SizedBox(height: 21),
                //       const Padding(
                //         padding: EdgeInsetsDirectional.symmetric(horizontal: 33),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Games(),
                //             Games(),
                //             Games(),
                //             Games(),
                //           ],
                //         ),
                //       ),
                //       const SizedBox(height: 21),
                //       const Padding(
                //         padding: EdgeInsetsDirectional.symmetric(horizontal: 33),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Games(),
                //             Games(),
                //             Games(),
                //             Games(),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
