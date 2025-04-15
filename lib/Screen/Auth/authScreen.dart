import 'package:flutter/material.dart';

import '../../common/text_style.dart';
import '../../utils/color_res.dart';
import '../../utils/string_res.dart';
import 'Widgets/loginScreen.dart';
import 'Widgets/signupScreen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: colorRes.blue,
            indicatorPadding: const EdgeInsets.only(left: 20, right: 20),
            indicatorWeight: 3,
            dividerColor: Colors.transparent,
            labelColor: colorRes.blue, // Color of the selected tab text
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  stringRes.login,
                  style: rubikMedium(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  stringRes.signup,
                  style: rubikMedium(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LoginScreen(),
            SignupScreen(),
          ],
        ),
      ),
    );
  }
}
