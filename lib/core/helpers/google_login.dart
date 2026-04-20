// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../../models/auth.dart';
//
// class GoogleLogin {
//   GoogleSignIn _signIn = GoogleSignIn(
//     scopes: ['profile'],
//     serverClientId:
//         "142999450104-shtr228n7rj5vjlm635adlci1gfb3fe9.apps.googleusercontent.com",
//   );
//
//   Future<Auth?> signIn() async {
//     try {
//       final GoogleSignInAccount? signInAccount = await _signIn.signIn();
//
//       if (signInAccount != null) {
//         final GoogleSignInAuthentication signInAuthentication =
//             await signInAccount.authentication;
//
//         return Auth(
//           userId: signInAccount.id,
//           email: signInAccount.email,
//           firstName: signInAccount.displayName?.split(' ').first ?? '',
//           lastName: signInAccount.displayName?.split(' ').last ?? '',
//           provider: "google",
//           providerId: signInAuthentication.idToken!,
//           accessToken: signInAuthentication.accessToken!,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error;$e");
//       //showErrorToast(LocaleKeys.unExpectedError.tr());
//     }
//
//     return null;
//   }
//
//   Future<void> signOut() async {
//     await _signIn.signOut();
//   }
// }
