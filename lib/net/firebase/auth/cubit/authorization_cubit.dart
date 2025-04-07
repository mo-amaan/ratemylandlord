import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../model/user_model/parent_model.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit() : super(AuthorizationSignedOut()) {
    _subscribe();
  }


  Future<void> _subscribe() async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        print("signed out");
        emit(AuthorizationSignedOut());
      }
      else {
        print("user is signed in");
      }
    });
  }

  Future<void> signIn(String email,String password) async {
    if(state is AuthorizationSignedOut) {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      String initials="" ;
      if (userCredential.user != null) {
        initials = userCredential.user?.displayName ?? "error";
      }
      print("user: ${userCredential.user}");
      emit(AuthorizationSignedIn(initials: initials));
    }
  }

  Future<void> signOut() async {
    if(state is AuthorizationSignedIn) {
      await FirebaseAuth.instance.signOut();
      emit(AuthorizationSignedOut());
    }
  }

  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && user.email!=null) {
        return user.email ?? "";
    }
    return "";
  }


  Future<void> setInitialsIfUnset(String initials) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && user.displayName != null) {
      await user.updateDisplayName(initials);

    }
  }

  Future<String> register(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.code;
    } catch (e) {
       print(e);
    }
    return "";

  }
  Future<void> setData(String type,String name)async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && user.displayName == null) {
      await user.updatePhotoURL(type);
      await user.updateDisplayName(name);
      print("here 4 ${user.displayName}");

    }
  }
  String getType() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && user.displayName != null) {
      return user.photoURL ?? "";
    }
    return "";
  }
  String getName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && user.displayName != null) {
      return user.displayName ?? "";
    }
    return "";
  }

  String getDateRegistered(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null ) {
      return user.metadata.creationTime.toString().split(" ")[0] ?? "";
    }
    return "";
  }

}