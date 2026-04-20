import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLauncher {
  Future<void> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  Future<void> launchPhoneNumber(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> launchTelegram(String telegramUser) async {
    final Uri uri = Uri.parse('https://t.me/$telegramUser');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Future<void> shareLinkWithTelegram(String link) async {
    final url = Uri.encodeFull("https://t.me/share/url?url=$link");
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> shareLinkWithFacebook(String link) async {
    final url = Uri.encodeFull(
      "https://www.facebook.com/sharer/sharer.php?u=$link",
    );
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> openPdfInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
