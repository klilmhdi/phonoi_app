import 'package:flutter/material.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/core/utils/widgets/dialoges.dart';
import 'package:phonoi_app/core/utils/widgets/snackbars_widgets.dart';
import 'package:phonoi_app/features/02-home/4-settings/view/setting_pages/change_font_size_screen.dart';
import 'package:phonoi_app/features/02-home/4-settings/view/setting_pages/change_language_screen.dart';
import 'package:phonoi_app/features/02-home/4-settings/view/setting_pages/download_settings.dart';
import 'package:phonoi_app/features/02-home/4-settings/view/setting_pages/notification_settings.dart';

import '../../../../generated/l10n.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                  title: Text(S.of(context).search_bar),
                  subtitle: Text("Google", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showSnackBar("سيتم اضافة هذه الميزة فالتحديث القادم", 3, context)),
              ListTile(
                  title: Text(S.of(context).pic),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showSnackBar("سيتم اضافة هذه الميزة فالتحديث القادم", 3, context)),
              ListTile(
                  title: Text(S.of(context).font_size),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, ChangeFontSizeScreen())),
              ListTile(
                  title: Text(S.of(context).lang),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, LanguageSelectionScreen())),
              Divider(),
              ListTile(
                  title: Text(S.of(context).downloads),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, DownloadSettingsScreen())),
              ListTile(
                  title: Text(S.of(context).notifications),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => navTo(context, NotificationSettingScreen())),
              ListTile(title: Text(S.of(context).clear_data), trailing: Icon(Icons.arrow_forward_ios), onTap: () {}),
              Divider(),
              ListTile(
                  title: Text(S.of(context).set_default),
                  trailing: Switch.adaptive(value: true, onChanged: (newValue) {}),
                  onTap: () {}),
              ListTile(
                  title: Text(S.of(context).search_updates),
                  subtitle: Text("Beta", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => loadingAlert(context)),
              ListTile(title: Text(S.of(context).about), trailing: Icon(Icons.arrow_forward_ios), onTap: () {}),
              ListTile(title: Text(S.of(context).rate_us), trailing: Icon(Icons.arrow_forward_ios), onTap: () {}),
              Divider(),
              ListTile(
                  title: Text(S.of(context).reset),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showSnackBar("سيتم اضافة هذه الميزة فالتحديث القادم", 3, context)),
            ],
          ),
        ),
      ),
    );
  }
}
