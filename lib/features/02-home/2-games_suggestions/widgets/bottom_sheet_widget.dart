import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showBottomSheetDialog(context) {
  Get.defaultDialog(
    title: 'الرجاء منح phonoi اذن الوصول للملفات \n لمساعدتك في ',
    titleStyle: const TextStyle(fontSize: 15),
    titlePadding: const EdgeInsetsDirectional.only(start: 45, end: 50, top: 12),
    backgroundColor: Colors.white,
    content: Column(
      children: [
        const SizedBox(height: 18),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 25),
              child: SizedBox(
                height: 16,
                width: 16,
                child: Image.asset('assets/icons/trash.png'),
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              "تنظيف الملفات المهمة",
              style: TextStyle(fontSize: 11),
            )
          ],
        ),
        const SizedBox(height: 21),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 25),
              child: SizedBox(
                height: 16,
                width: 16,
                child: Image.asset('assets/icons/whatsapp.png'),
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              "  حفظ حالات whatsapp",
              style: TextStyle(fontSize: 11),
            )
          ],
        ),
        const SizedBox(height: 21),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 25),
              child: SizedBox(
                height: 16,
                width: 16,
                child: Image.asset('assets/icons/Group 17.png'),
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              " عرض جميع المستندات",
              style: TextStyle(fontSize: 11),
            )
          ],
        ),
        const SizedBox(height: 21),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 25),
              child: SizedBox(
                height: 16,
                width: 16,
                child: Image.asset('assets/icons/Layer 2.png'),
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              "تشغيل جميع الموسيقى الخاصة بك بدون انترنت",
              style: TextStyle(fontSize: 11),
            )
          ],
        ),
        const SizedBox(height: 28),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/permission_access_screen');
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(263, 33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              backgroundColor: const Color(0xff8C52FF)),
          child: const Text(
            'متابعة',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        // SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity)),
          child: const Text(
            'ليس الأن',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff5D5D5D),
            ),
          ),
        ),
      ],
    ),
  );
}
