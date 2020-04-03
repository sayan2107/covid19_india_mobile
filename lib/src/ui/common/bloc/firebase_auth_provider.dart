import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:corona_trac_helper/src/base/base_repository.dart';

class FirebaseAuthProvider extends BaseRepository{
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  Future<GoogleSignInAccount> handleSignIn() async {
    try {
      GoogleSignInAccount response;
      response = await _googleSignIn.signIn();
      if(response != null) {
        return response;
      } else {
        return Future.value(response);
      }
    } on DioError catch(e) {
      return Future.value(e.error);
    }
  }
}