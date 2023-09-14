import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../01-auth/models/user_model.dart';
import '../../../data/models/social_web_view_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;

  static HomeCubit get(context) => BlocProvider.of(context, listen: false);

  List<SocialWebViewItem> getItems(BuildContext context) {
    final items = [
      SocialWebViewItem(
          imagesName: "assets/icons/youtube.png", name: S.of(context).youtube, url: "https://www.YouTube.com"),
      SocialWebViewItem(
          imagesName: "assets/icons/facebook.png", name: S.of(context).facebook, url: "https://www.facebook.com"),
      SocialWebViewItem(
          imagesName: "assets/icons/twitter.png", name: S.of(context).twitter, url: "https://www.Twitter.com"),
      SocialWebViewItem(
          imagesName: "assets/icons/instagram.png", name: S.of(context).insta, url: "https://www.Instagram.com"),
      SocialWebViewItem(
          imagesName: "assets/icons/palsawa.png", name: S.of(context).pal_sawa, url: "https://palsawa.com/"),
      SocialWebViewItem(
          imagesName: "assets/icons/sama.png", name: S.of(context).sama, url: "https://www.samanews.ps/ar/"),
      SocialWebViewItem(
          imagesName: "assets/icons/alwatan.png", name: S.of(context).donia, url: "https://www.alwatanvoice.com"),
      SocialWebViewItem(
          imagesName: "assets/icons/wta.png", name: S.of(context).watan, url: "https://www.wattan.net/ar/"),
    ];

    return items;
  }
}
