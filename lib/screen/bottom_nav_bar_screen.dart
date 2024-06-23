import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrititech/screen/home_screen.dart';
import 'package:vrititech/screen/like_screen.dart';
import 'package:vrititech/screen/profile_screen.dart';

import '../bloc/bottom_nav_bar_bloc/home_page_bloc.dart';
import '../constants/color_constant.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({
    super.key,
  });

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  DateTime? backButtonPressTime;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          switch (state) {
            case Page1():
              return const HomeScreen();
            case Page2():
              return const LikeScreen();
            case Page3():
              return const ProfileScreen();
            default:
              return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: Container(
        height: Platform.isAndroid ? 60 : null,
        margin: Platform.isAndroid
            ? const EdgeInsets.only(
                left: 20,
                bottom: 20,
                right: 20,
              )
            : null,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: [
            BoxShadow(
              color: shadowColor.withOpacity(0.3),
              blurRadius: 2,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: primaryColor,
            elevation: 0.0,
            showSelectedLabels: true,
            unselectedItemColor: shadowColor,
            showUnselectedLabels: true,
            selectedItemColor: secondaryColor,
            currentIndex: _selectedIndex,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              color: shadowColor,
            ),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
            onTap: (currentIndex) {
              _selectedIndex = currentIndex;
              context
                  .read<HomePageBloc>()
                  .add(HomePageClickEvent(id: currentIndex));
              (context as Element).markNeedsBuild();
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "HOME",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart_circle),
                label: "LIKE",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: "PROFILE",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
