// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello `
  String get hello {
    return Intl.message(
      'Hello ',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `We care about your privacy`
  String get we_care_about {
    return Intl.message(
      'We care about your privacy',
      name: 'we_care_about',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to join Phonoi For your convenience, here we present the part related to your biggest concerns about`
  String get welcome_to_join_phonoi {
    return Intl.message(
      'Welcome to join Phonoi For your convenience, here we present the part related to your biggest concerns about',
      name: 'welcome_to_join_phonoi',
      desc: '',
      args: [],
    );
  }

  /// `What we don't`
  String get what_we_dont {
    return Intl.message(
      'What we don\'t',
      name: 'what_we_dont',
      desc: '',
      args: [],
    );
  }

  /// `We don't record how you use your Phonoi connection, which means we don't see what apps, services, or websites you personally use while connected to our service, and we don't store them. \n We do not store your original IP address or the IP of the server you are on\n You connect to it which means we can't share it with anyone no matter what happened.\n We do not sell, use or disclose any personal data to third parties not mentioned in this Privacy Policy for any purpose.\n We do not sell, use or disclose any personal data to third parties not mentioned in this Privacy Policy for any purpose.\n We have designed our systems so that they do not contain sensitive data about our customers, even when forced, we cannot provide data that we do not have.`
  String get desc_for_what_we_dont {
    return Intl.message(
      'We don\'t record how you use your Phonoi connection, which means we don\'t see what apps, services, or websites you personally use while connected to our service, and we don\'t store them. \n We do not store your original IP address or the IP of the server you are on\n You connect to it which means we can\'t share it with anyone no matter what happened.\n We do not sell, use or disclose any personal data to third parties not mentioned in this Privacy Policy for any purpose.\n We do not sell, use or disclose any personal data to third parties not mentioned in this Privacy Policy for any purpose.\n We have designed our systems so that they do not contain sensitive data about our customers, even when forced, we cannot provide data that we do not have.',
      name: 'desc_for_what_we_dont',
      desc: '',
      args: [],
    );
  }

  /// `What we collect, how and why`
  String get what_we_connect {
    return Intl.message(
      'What we collect, how and why',
      name: 'what_we_connect',
      desc: '',
      args: [],
    );
  }

  /// `Account details`
  String get account_details {
    return Intl.message(
      'Account details',
      name: 'account_details',
      desc: '',
      args: [],
    );
  }

  /// `Registration date and email address (only if you choose to register by mail electronic) and subscription status (only if you made a purchase) This data is collected automatically during procedures, including registration and purchase.\nIt is used strictly for user support purpose.`
  String get desc_for_accout_details {
    return Intl.message(
      'Registration date and email address (only if you choose to register by mail electronic) and subscription status (only if you made a purchase) This data is collected automatically during procedures, including registration and purchase.\nIt is used strictly for user support purpose.',
      name: 'desc_for_accout_details',
      desc: '',
      args: [],
    );
  }

  /// `Application activity data`
  String get application_activity_data {
    return Intl.message(
      'Application activity data',
      name: 'application_activity_data',
      desc: '',
      args: [],
    );
  }

  /// `Connection timestamp, protocol selection, network type and report error This data is collected automatically during phonoi connection and is used for troubleshooting and improving phonoi service only.`
  String get desc_for_app_activity_data {
    return Intl.message(
      'Connection timestamp, protocol selection, network type and report error This data is collected automatically during phonoi connection and is used for troubleshooting and improving phonoi service only.',
      name: 'desc_for_app_activity_data',
      desc: '',
      args: [],
    );
  }

  /// `Another data`
  String get another_data {
    return Intl.message(
      'Another data',
      name: 'another_data',
      desc: '',
      args: [],
    );
  }

  /// `Data Analysis: Giving history and usage data. Records notes: Users via the system chat service customers phonoi or by email`
  String get desc_for_another_data {
    return Intl.message(
      'Data Analysis: Giving history and usage data. Records notes: Users via the system chat service customers phonoi or by email',
      name: 'desc_for_another_data',
      desc: '',
      args: [],
    );
  }

  /// `Please note that this is just part of the terms, click Privacy Policy and Terms of Service to view the full version by clicking the “Agree and Continue” button you clearly understand and agree subject to all terms stipulated in the Privacy Policy and terms of service`
  String get check_privacy_policy {
    return Intl.message(
      'Please note that this is just part of the terms, click Privacy Policy and Terms of Service to view the full version by clicking the “Agree and Continue” button you clearly understand and agree subject to all terms stipulated in the Privacy Policy and terms of service',
      name: 'check_privacy_policy',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'approval_and_follow up' key

  /// `Login`
  String get log_in {
    return Intl.message(
      'Login',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get log_out {
    return Intl.message(
      'Logout',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Log in to a browser Phonoi`
  String get log_in_title {
    return Intl.message(
      'Log in to a browser Phonoi',
      name: 'log_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Continue with google`
  String get log_in_google {
    return Intl.message(
      'Continue with google',
      name: 'log_in_google',
      desc: '',
      args: [],
    );
  }

  /// `Continue with facebook`
  String get log_in_facebook {
    return Intl.message(
      'Continue with facebook',
      name: 'log_in_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with twitter`
  String get log_in_twitter {
    return Intl.message(
      'Continue with twitter',
      name: 'log_in_twitter',
      desc: '',
      args: [],
    );
  }

  /// `Log in using your email`
  String get log_in_email {
    return Intl.message(
      'Log in using your email',
      name: 'log_in_email',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get name {
    return Intl.message(
      'Full Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `verify using email`
  String get using_email {
    return Intl.message(
      'verify using email',
      name: 'using_email',
      desc: '',
      args: [],
    );
  }

  /// `verify using phone`
  String get using_phone {
    return Intl.message(
      'verify using phone',
      name: 'using_phone',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `This field is empty, please fill in this field`
  String get input_validate {
    return Intl.message(
      'This field is empty, please fill in this field',
      name: 'input_validate',
      desc: '',
      args: [],
    );
  }

  /// `Please type the name correctly!!`
  String get name_input_validate {
    return Intl.message(
      'Please type the name correctly!!',
      name: 'name_input_validate',
      desc: '',
      args: [],
    );
  }

  /// `Please type the email correctly!!`
  String get email_input_validate {
    return Intl.message(
      'Please type the email correctly!!',
      name: 'email_input_validate',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one character`
  String get pass_input_validate1 {
    return Intl.message(
      'Password must contain at least one character',
      name: 'pass_input_validate1',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get pass_input_validate2 {
    return Intl.message(
      'Password must contain at least one number',
      name: 'pass_input_validate2',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one short character`
  String get pass_input_validate3 {
    return Intl.message(
      'Password must contain at least one short character',
      name: 'pass_input_validate3',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one capital letter`
  String get pass_input_validate4 {
    return Intl.message(
      'Password must contain at least one capital letter',
      name: 'pass_input_validate4',
      desc: '',
      args: [],
    );
  }

  /// `Password must be greater than or equal to 8 characters`
  String get pass_input_validate5 {
    return Intl.message(
      'Password must be greater than or equal to 8 characters',
      name: 'pass_input_validate5',
      desc: '',
      args: [],
    );
  }

  /// `The provided phone number is not valid, Try again.`
  String get phone_verify_error {
    return Intl.message(
      'The provided phone number is not valid, Try again.',
      name: 'phone_verify_error',
      desc: '',
      args: [],
    );
  }

  /// `After success signup, choose 1 of verification methods to complete verify account`
  String get select_verity_method {
    return Intl.message(
      'After success signup, choose 1 of verification methods to complete verify account',
      name: 'select_verity_method',
      desc: '',
      args: [],
    );
  }

  /// `Signup successfully`
  String get select_verity_method_title {
    return Intl.message(
      'Signup successfully',
      name: 'select_verity_method_title',
      desc: '',
      args: [],
    );
  }

  /// `Download any video or movie from anywhere easily`
  String get on_boarding_1 {
    return Intl.message(
      'Download any video or movie from anywhere easily',
      name: 'on_boarding_1',
      desc: '',
      args: [],
    );
  }

  /// `Download series and the movies are in high quality`
  String get on_boarding_2 {
    return Intl.message(
      'Download series and the movies are in high quality',
      name: 'on_boarding_2',
      desc: '',
      args: [],
    );
  }

  /// `Download from all \ncommunication sites the social`
  String get on_boarding_3 {
    return Intl.message(
      'Download from all \ncommunication sites the social',
      name: 'on_boarding_3',
      desc: '',
      args: [],
    );
  }

  /// `Download any video or movie from anywhere on the Internet \n with one click of a button and without annoying ads`
  String get desc_on_boarding {
    return Intl.message(
      'Download any video or movie from anywhere on the Internet \n with one click of a button and without annoying ads',
      name: 'desc_on_boarding',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get me {
    return Intl.message(
      'My Account',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Search or type a web address`
  String get search {
    return Intl.message(
      'Search or type a web address',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `If you want to download the link directly,`
  String get if_you_want_download_directly {
    return Intl.message(
      'If you want to download the link directly,',
      name: 'if_you_want_download_directly',
      desc: '',
      args: [],
    );
  }

  /// `Click Here!!`
  String get click_here {
    return Intl.message(
      'Click Here!!',
      name: 'click_here',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Allow access to your music files`
  String get allow_access_music_file {
    return Intl.message(
      'Allow access to your music files',
      name: 'allow_access_music_file',
      desc: '',
      args: [],
    );
  }

  /// `Allow access to your image files`
  String get allow_access_image_file {
    return Intl.message(
      'Allow access to your image files',
      name: 'allow_access_image_file',
      desc: '',
      args: [],
    );
  }

  /// `Allow access to your video files`
  String get allow_access_video_file {
    return Intl.message(
      'Allow access to your video files',
      name: 'allow_access_video_file',
      desc: '',
      args: [],
    );
  }

  /// `Best Games`
  String get games {
    return Intl.message(
      'Best Games',
      name: 'games',
      desc: '',
      args: [],
    );
  }

  /// `Storage`
  String get storage {
    return Intl.message(
      'Storage',
      name: 'storage',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get downloads {
    return Intl.message(
      'Downloads',
      name: 'downloads',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to sync\n your data, & get features`
  String get sign_in_title {
    return Intl.message(
      'Sign in to sync\n your data, & get features',
      name: 'sign_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add Link Here!`
  String get enter_link {
    return Intl.message(
      'Add Link Here!',
      name: 'enter_link',
      desc: '',
      args: [],
    );
  }

  /// `Put the link you want to download here`
  String get enter_link_desc {
    return Intl.message(
      'Put the link you want to download here',
      name: 'enter_link_desc',
      desc: '',
      args: [],
    );
  }

  /// `Paste link`
  String get paste_link {
    return Intl.message(
      'Paste link',
      name: 'paste_link',
      desc: '',
      args: [],
    );
  }

  /// `Delete link`
  String get delete {
    return Intl.message(
      'Delete link',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Download link`
  String get download {
    return Intl.message(
      'Download link',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Downloading now`
  String get downloading_now {
    return Intl.message(
      'Downloading now',
      name: 'downloading_now',
      desc: '',
      args: [],
    );
  }

  /// `Download Form: `
  String get download_from {
    return Intl.message(
      'Download Form: ',
      name: 'download_from',
      desc: '',
      args: [],
    );
  }

  /// `Try to download your link in another time!!!`
  String get download_failed {
    return Intl.message(
      'Try to download your link in another time!!!',
      name: 'download_failed',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded Completed: `
  String get downloading_completed {
    return Intl.message(
      'Downloaded Completed: ',
      name: 'downloading_completed',
      desc: '',
      args: [],
    );
  }

  /// `Please, check if your link is correct then try again!!`
  String get check_link {
    return Intl.message(
      'Please, check if your link is correct then try again!!',
      name: 'check_link',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Twitter`
  String get twitter {
    return Intl.message(
      'Twitter',
      name: 'twitter',
      desc: '',
      args: [],
    );
  }

  /// `Youtube`
  String get youtube {
    return Intl.message(
      'Youtube',
      name: 'youtube',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get insta {
    return Intl.message(
      'Instagram',
      name: 'insta',
      desc: '',
      args: [],
    );
  }

  /// `TicTok`
  String get tictok {
    return Intl.message(
      'TicTok',
      name: 'tictok',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message(
      'Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Sama`
  String get sama {
    return Intl.message(
      'Sama',
      name: 'sama',
      desc: '',
      args: [],
    );
  }

  /// `Pal Sawa`
  String get pal_sawa {
    return Intl.message(
      'Pal Sawa',
      name: 'pal_sawa',
      desc: '',
      args: [],
    );
  }

  /// `Donia ElWatan`
  String get donia {
    return Intl.message(
      'Donia ElWatan',
      name: 'donia',
      desc: '',
      args: [],
    );
  }

  /// `Watan`
  String get watan {
    return Intl.message(
      'Watan',
      name: 'watan',
      desc: '',
      args: [],
    );
  }

  /// `Music (High Quality)`
  String get music_option {
    return Intl.message(
      'Music (High Quality)',
      name: 'music_option',
      desc: '',
      args: [],
    );
  }

  /// `Video (High Quality)`
  String get video_option {
    return Intl.message(
      'Video (High Quality)',
      name: 'video_option',
      desc: '',
      args: [],
    );
  }

  /// `The last websites`
  String get last_website {
    return Intl.message(
      'The last websites',
      name: 'last_website',
      desc: '',
      args: [],
    );
  }

  /// `There are no download tasks yet`
  String get downloads_is_empty {
    return Intl.message(
      'There are no download tasks yet',
      name: 'downloads_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarks`
  String get bookmarks {
    return Intl.message(
      'Bookmarks',
      name: 'bookmarks',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Themes`
  String get themes {
    return Intl.message(
      'Themes',
      name: 'themes',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message(
      'Likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Join us on our Facebook website`
  String get join_us {
    return Intl.message(
      'Join us on our Facebook website',
      name: 'join_us',
      desc: '',
      args: [],
    );
  }

  /// `Share Phonoi`
  String get share_app {
    return Intl.message(
      'Share Phonoi',
      name: 'share_app',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get help_center {
    return Intl.message(
      'Help Center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Search Engine`
  String get search_bar {
    return Intl.message(
      'Search Engine',
      name: 'search_bar',
      desc: '',
      args: [],
    );
  }

  /// `Picture`
  String get pic {
    return Intl.message(
      'Picture',
      name: 'pic',
      desc: '',
      args: [],
    );
  }

  /// `Font Size`
  String get font_size {
    return Intl.message(
      'Font Size',
      name: 'font_size',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Clear data`
  String get clear_data {
    return Intl.message(
      'Clear data',
      name: 'clear_data',
      desc: '',
      args: [],
    );
  }

  /// `Set as default browser`
  String get set_default {
    return Intl.message(
      'Set as default browser',
      name: 'set_default',
      desc: '',
      args: [],
    );
  }

  /// `Search Updates`
  String get search_updates {
    return Intl.message(
      'Search Updates',
      name: 'search_updates',
      desc: '',
      args: [],
    );
  }

  /// `About Phonoi`
  String get about {
    return Intl.message(
      'About Phonoi',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Rate us`
  String get rate_us {
    return Intl.message(
      'Rate us',
      name: 'rate_us',
      desc: '',
      args: [],
    );
  }

  /// `Reset default settings`
  String get reset {
    return Intl.message(
      'Reset default settings',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to skip login ?`
  String get cancel_login {
    return Intl.message(
      'Are you sure to skip login ?',
      name: 'cancel_login',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to need logout ?`
  String get cancel_logout {
    return Intl.message(
      'Are you sure to need logout ?',
      name: 'cancel_logout',
      desc: '',
      args: [],
    );
  }

  /// `All Music`
  String get all_music {
    return Intl.message(
      'All Music',
      name: 'all_music',
      desc: '',
      args: [],
    );
  }

  /// `No Musics found!!`
  String get no_musics {
    return Intl.message(
      'No Musics found!!',
      name: 'no_musics',
      desc: '',
      args: [],
    );
  }

  /// `Sign up firstly before download videos`
  String get go_to_sign_up {
    return Intl.message(
      'Sign up firstly before download videos',
      name: 'go_to_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `We're working to develop it`
  String get we_develop_it {
    return Intl.message(
      'We\'re working to develop it',
      name: 'we_develop_it',
      desc: '',
      args: [],
    );
  }

  /// `Pictures`
  String get pictures {
    return Intl.message(
      'Pictures',
      name: 'pictures',
      desc: '',
      args: [],
    );
  }

  /// `Musics`
  String get musics {
    return Intl.message(
      'Musics',
      name: 'musics',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Apps`
  String get apps {
    return Intl.message(
      'Apps',
      name: 'apps',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp Media`
  String get whatsapp {
    return Intl.message(
      'Whatsapp Media',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Instagram Media`
  String get instegram {
    return Intl.message(
      'Instagram Media',
      name: 'instegram',
      desc: '',
      args: [],
    );
  }

  /// `Compressed files`
  String get compreseds {
    return Intl.message(
      'Compressed files',
      name: 'compreseds',
      desc: '',
      args: [],
    );
  }

  /// `Photo gallery`
  String get gallery {
    return Intl.message(
      'Photo gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arab {
    return Intl.message(
      'Arabic',
      name: 'arab',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get engl {
    return Intl.message(
      'English',
      name: 'engl',
      desc: '',
      args: [],
    );
  }

  /// `Change theme`
  String get change_theme {
    return Intl.message(
      'Change theme',
      name: 'change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_lang {
    return Intl.message(
      'Select Language',
      name: 'select_lang',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
