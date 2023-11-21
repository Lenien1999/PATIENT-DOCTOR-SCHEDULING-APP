import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../auth/auth_controller/auth_model.dart';
import '../auth/auth_controller/authcontroller.dart';
import '../constants/app_style.dart';
import '../db_manager/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My profile",
          style: TextStyle(
              color: AppColor.backColor(), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
              color: Colors.black)
        ],
      ),
      body: StreamBuilder<UserModel?>(
          stream:
              FirebaseMethods().userStream(controller.fireBaseUser.value!.uid),
          builder: (BuildContext context, snapshot) {
            UserModel? userData = snapshot.data;

            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/profile.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColor.backColor()),
                              child: const Icon(
                                LineAwesomeIcons.alternate_pencil,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Coding with ${userData!.fullName}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user!.email ?? 'user@gmail.com',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.backColor(),
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          onPressed: () {
                            // Get.to(() => const EditProfile());
                          },
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileWidget(
                        icon: LineAwesomeIcons.cog,
                        onpress: () {},
                        title: 'Settings',
                      ),
                      ProfileWidget(
                        icon: LineAwesomeIcons.wallet,
                        onpress: () {},
                        title: 'Billing Details',
                      ),
                      ProfileWidget(
                        icon: LineAwesomeIcons.user_check,
                        onpress: () {},
                        title: 'User Mnagement',
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileWidget(
                        icon: LineAwesomeIcons.info,
                        onpress: () {},
                        title: 'Information',
                      ),
                      ProfileWidget(
                        endIcon: false,
                        icon: LineAwesomeIcons.alternate_sign_out,
                        onpress: () async {
                          await controller.logout();
                        },
                        title: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;
  const ProfileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.amber.withOpacity(0.1)),
        child: Icon(
          icon,
          color: AppColor.bgColor(),
        ),
      ),
      title: GestureDetector(
        onTap: onpress,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
