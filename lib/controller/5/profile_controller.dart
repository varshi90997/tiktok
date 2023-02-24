import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/const.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];//                                          ((1))--thumbnail mate
    var myVideos = await firestore//======================================================>'uid' same hoy _uid.value sathe teva collection no instance return karshe------>myVideos malshe
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();


    for (int i = 0; i < myVideos.docs.length; i++) {//====================================>myVideos na thumbnail ne map ma store kravya

      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
      //print("======================================================>m ${thumbnails.toString()}");

    }


    //====================================>all items ni andar value muki      ((2))----[important]--->like live store thay che map ma firebase vgar
    DocumentSnapshot userDoc = await firestore.collection('users').doc(_uid.value).get();

    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {

      likes += (item.data()['likes'] as List).length;

    }
    ///===========================================> followers and following mgavya   ((3))---->followers and following mgavya  store kravya
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    //===========================================> add
    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });
    //===========================================> add all value in map format     ((4))---->add all value in map format
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };
    update();//GetBuilder( id: ) update,
  }

  followUser() async {///===========================>.doc(_uid.value) varshil na ------------->follower ma-----------> authController.user.uid [rumit].curren user--------->male
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
                      //malshe nai so
    if (!doc.exists) {//----------------------------------------->follow mate
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
            (value) => (int.parse(value) + 1).toString(),
      );

    } else {//---------------------------------------------------->unfollow mate
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
            (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}