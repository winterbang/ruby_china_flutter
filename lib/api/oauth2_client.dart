//import 'dart:io';
// import 'package:oauth2/oauth2.dart' as oauth2;

// class OauthClient {
//   static final authorizationEndpoint = Uri.parse("https://ruby-china.org/oauth/authorize");
//   static final tokenEndpoint = Uri.parse("https://ruby-china.org/oauth/token");
//   static final identifier = "b684b421";
//   static final secret = "3017a215f76a31b7aee6eed71b3e0ae4db44fef57acc0066258f94ccfd6aa8f6";
//   static final redirectUrl = Uri.parse("http://my-site.com/oauth2-redirect");

//   static
//   Future<oauth2.Client> getClient() async {
//     var grant = new oauth2.AuthorizationCodeGrant(
//       identifier, authorizationEndpoint, tokenEndpoint,
//       secret: secret);

// //    await redirect(grant.getAuthorizationUrl(redirectUrl));
// //
// //    var request = await listen(redirectUrl);

//     return await grant.handleAuthorizationResponse({});
//   }
// }
