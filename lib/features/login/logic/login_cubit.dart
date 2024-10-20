import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
   signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential= await auth.signInWithCredential(credential);
    if(userCredential.user!=null){
      addUserToFirestore(userCredential.user!);
    }
    emit(CompleteLogin());
  }
   signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    final userCredential=await auth.signInWithCredential(facebookAuthCredential);
     if(userCredential.user!=null){
       addUserToFirestore(userCredential.user!);
     }
    emit(CompleteLogin());
   }


   addUserToFirestore(User user) async {
     if(!await isUserExit(user.uid)){
       await firestore.collection('Users').doc(user.uid).set({
         'name':user.displayName,
         'img':'',
         'uid':user.uid,
         'provider':user.providerData.first.providerId
       });
     }
   }
  Future<bool> isUserExit(String uid)async{
    bool flag=false;
    await firestore.collection('Users').doc(uid).get().then((value) {
      if(value.exists){
        flag=true;
      }
    },);
    return flag;
  }
}
