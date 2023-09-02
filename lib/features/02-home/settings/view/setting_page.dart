import 'package:flutter/material.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/core/utils/widgets/dialoges.dart';
import 'package:phonoi_app/core/utils/widgets/snackbars_widgets.dart';
import 'package:phonoi_app/features/02-home/settings/view/setting_pages/change_font_size_screen.dart';
import 'package:phonoi_app/features/02-home/settings/view/setting_pages/change_language_screen.dart';
import 'package:phonoi_app/features/02-home/settings/view/setting_pages/download_settings.dart';
import 'package:phonoi_app/features/02-home/settings/view/setting_pages/notification_settings.dart';
import 'package:quickalert/quickalert.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                  title: Text("محركات البحث"),
                  subtitle: Text("Google", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showSnackBar("سيتم اضافة هذه الميزة فالتحديث القادم", 3, context)),
              ListTile(
                  title: Text("الصورة"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showSnackBar("سيتم اضافة هذه الميزة فالتحديث القادم", 3, context)),
              ListTile(
                  title: Text("حجم الخط"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, ChangeFontSizeScreen())),
              ListTile(
                  title: Text("اللغة"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, LanguageSelectionScreen())),
              Divider(),
              ListTile(
                  title: Text("التنزيلات"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, DownloadSettingsScreen())),
              ListTile(
                  title: Text("الإشعارات"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, NotificationSettingScreen())),
              ListTile(title: Text("مسح البيانات"), trailing: Icon(Icons.arrow_forward_ios), onTap: () {}),
              Divider(),
              ListTile(
                  title: Text("تعيين كمتصفح افتراضي"),
                  trailing: Switch.adaptive(value: true, onChanged: (newValue) {}),
                  onTap: () {}),
              ListTile(
                  title: Text("البحث عن تحديثات"),
                  subtitle: Text("1.2.00", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => loadingAlert(context)),
              ListTile(title: Text("حول Phonoi"), trailing: Icon(Icons.arrow_forward_ios), onTap: () {}),
              ListTile(title: Text("قيمنا"), trailing: Icon(Icons.arrow_forward_ios), onTap: () {}),
              Divider(),
              ListTile(
                  title: Text("إعادة تعيين المتصفحات الافتراضية"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showSnackBar("سيتم اضافة هذه الميزة فالتحديث القادم", 3, context)),
            ],
          ),
        ),
      ),
    );
  }
}
