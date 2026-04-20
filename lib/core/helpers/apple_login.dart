

// class AppleLogin {
//   final signInWithApple = SignInWithApple();
//
//   Future<Auth?> signIn() async {
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.fullName,
//         AppleIDAuthorizationScopes.email,
//       ],
//     );
//
//     return Auth(
//       userId: credential.userIdentifier!,
//       email: credential.email ?? '',
//       firstName: credential.givenName ?? '',
//       provider: 'apple',
//       lastName: credential.familyName,
//       accessToken: credential.identityToken,
//       providerId: credential.userIdentifier,
//     );
//       return null;
//   }
// }
