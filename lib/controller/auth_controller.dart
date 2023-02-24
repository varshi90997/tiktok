import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/const.dart';
import 'package:tiktok/model/user.dart' as model;
import 'package:tiktok/view/screen/auth/login_screen.dart';
import 'package:tiktok/view/screen/home_screen.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();///------->const ma mukva mate
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);//=======>firebase na user ne
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);//==========>firebase na user nu authStateChanges thasw to _setInitialScreen() function load thashe
  }
  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);///---------->Reference ni andar file put karvi
    TaskSnapshot snap = await uploadTask;///---------------->snapshot thi dounload image mangavi shkay
    String downloadUrl = await snap.ref.getDownloadURL();///--->snapshot through Reference mathi getDownloadURL() function throuh url magavi
    return downloadUrl;
  }

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null) {
        /// ================>>save out user to our auth
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        ///================>> store image in firebase storage
        String downloadUrl = await _uploadToStorage(image);
        ///================>> store userdata in firestore database i
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)///========================================================>w2GDKnKlI0RYnL7Q6hA58rtQQQW2 avi uniq id ave user ni
            .set(user.toMap());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      print(email);
      print(password);
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin in',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}