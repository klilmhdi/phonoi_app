import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';

import '../../core/utils/functions/functions.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC4C4C4),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15.w, top: 10.h, end: 15.w),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: const Color(0xffF2F2F2), borderRadius: BorderRadius.circular(10)),
                  height: 1077.h,
                  // width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 31.w,
                        start: 11.w,
                        top: 17.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // textDirection: TextDirection.ltr,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 55.w),
                            child: SizedBox(
                              width: 208.w,
                              height: 31.h,
                              child: Text(
                                'نحن نهتم بخصوصياتك',
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.normal,
                                ),
                                //  textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                          SizedBox(height: 22.h),
                          SizedBox(
                            // width: 304.w,
                            // height: 85.h,
                            child: Text(
                              'من أجل phonoi مرحبا في الأنضمام الى\n راحتك , نقدم هنا الجزء المتعلق بأكبر مخاوفك \n بشأن سياسة الخصوصية .',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: const Color(0xff000000),
                                // fontWeight: FontWeight.r,
                              ),
                              //  textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 29.h),
                          SizedBox(
                            // width: 72.w,
                            child: Text(
                              'ما لا نفعله',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: const Color(0xff000000),
                              ),
                              //  textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              "  نحن لا نسجل كيفية استخدامك لاتصال Phonoi مما يعني أننا لانرى \nلتطبيقات او الخدمة او المواقع الويب التي تستخدمها شخصيا اثناء\nالاتصال بخدمتنا ، ولا نقوم بتخزينها.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            child: Text(
                              "  لا نقوم بتخزين عنوان ال IP الاصلي الخاص بك أو IP للخادم الذي \nتتصل به مما يعني أنه لا يمكننا مشاركته مع أي شخص بغض \nالنظر عما حدث.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            child: Text(
                              "  لا نقوم ببيع أو استخدام أو كشف عن أي بيانات شخصية لأطراف \nثالثة غيرمذكورة في هذه الخصوصية لأي غرض.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            child: Text(
                              "  لقد صممنا أنظمتنا بحيث لا تحتوي على بيانات حساسة عن عملائنا \nحتى عند الاضطرار , لايمكننا بيانات لا نمتلكها.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 29.h),
                          SizedBox(
                            // width: 153.w,
                            child: Text(
                              'ما نجمعه وكيف ولماذا',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: const Color(0xff000000),
                              ),
                              // // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Color(0xff8C52FF),
                                size: 16,
                              ),
                              SizedBox(width: 10.w),
                              SizedBox(
                                child: Text(
                                  'بيانات الحساب',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff000000),
                                  ),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h),
                          SizedBox(
                            child: Text(
                              "  تاريخ تسجيل وعنوان البريد الإلكتروني (فقط إذا إخترت التسجيل بالبريد \nالالكتروني) وحالة الاشتراك (فقط اذا قمت بالشرء) يتم جمه هذه \nالبيانات تلقائيا أثناء الاجراءات بما في ذلك التسجيل والشراء \nيتم استخدامه بشكل صارم لغرض دعم المستخدم",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 51.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Color(0xff8C52FF),
                                size: 16,
                              ),
                              SizedBox(width: 10.w),
                              SizedBox(
                                // width: 153.w,
                                child: Text(
                                  'بيانات نشاط التطبيق',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff000000),
                                  ),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h),
                          SizedBox(
                            child: Text(
                              "  الطابع الزمني للاتصال واختيار البروتوكول ونوع الشبكة وتقرير \n الخطأ يتم جمع هذه المعلومات تلقائيا أثناء اتصال Phonoi فقط وتستخدم  \nلاستكشاف الأخطاء واصلاحها وتحسين خدمة Phonoi . ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 51.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Color(0xff8C52FF),
                                size: 16,
                              ),
                              SizedBox(width: 10.w),
                              SizedBox(
                                // width: 153.w,
                                child: Text(
                                  'بيانات الجهاز والموقع',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff000000),
                                  ),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h),
                          SizedBox(
                            child: Text(
                              " معلومات الجهاز ID العشوائي  غير معروف واصدار العميل والموقع  \nالجغرافي (على مستوى المدينة)يتم جمع هذه المعلومات تلقائيا عند  \nفتح Phonoi وتساعدنا على فعم مستخدمينا وتخطيط المنتج بشكل  \nأفضل  , لزيادة تحسين تجربة المستخدم ورضا المستحدم",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 51.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Color(0xff8C52FF),
                                size: 16,
                              ),
                              SizedBox(width: 10.w),
                              SizedBox(
                                // width: 153.w,
                                child: Text(
                                  'بيانات أخري',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff000000),
                                  ),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h),
                          SizedBox(
                            child: Text(
                              " بيانات التحليل : سجل الأعطاء واستخدام البيانات  \nسجلات الملاحظات : المستخدمين عبر نظام دردشة أو خدمة العملاء \nأو عن طريق البريد الالكتروني ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff5D5D5D),
                                // fontWeight: FontWeight.r,
                              ),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(height: 21.h),
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // textDirection: TextDirection.ltr,
                              children: [
                                Text(
                                  " يرجى ملاحظة أن هذا مجرد جزء من الشروط , أنقر فوق",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff5D5D5D),
                                    // fontWeight: FontWeight.r,
                                  ),
                                  // textDirection: TextDirection.rtl,
                                ),
                                Row(
                                  // textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(
                                          horizontal: VisualDensity.minimumDensity,
                                          vertical: VisualDensity.minimumDensity,
                                        ),
                                      ),
                                      child: Text(
                                        'سياسة الاستخدام',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                    Text(
                                      "و ",
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(
                                          horizontal: VisualDensity.minimumDensity,
                                          vertical: VisualDensity.minimumDensity,
                                        ),
                                      ),
                                      child: Text(
                                        ' شروط الخدمة ',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                    Text(
                                      "لعرض الاصدار بالكامل",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xff5D5D5D),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "بالنقر فوق الزر 'الموافقة والمتابعة' فأنك تفهم وتوافق بوضوح \n على جميع الشروط المنصوص عليها في سياسة الخصوصية \nوشرط الخدمة .",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff5D5D5D),
                                  ),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 106.h),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    height: 82.h,
                    width: 346.w,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 10.5.w,
                        end: 10.5.w,
                        top: 20.5.h,
                        bottom: 20.5.h,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(325.w, 41.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: const Color(0xff8C52FF),
                        ),
                        onPressed: () {
                          navAndFinish(context, Layout());
                        },
                        child: Text(
                          'موافقة ومتابعة',
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
