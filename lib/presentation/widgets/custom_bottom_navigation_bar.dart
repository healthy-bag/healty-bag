
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget{
  const CustomBottomNavigationBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  final int activeIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIcons: [
        Icon(Icons.person, color: Colors.white,),
        Icon(Icons.home, color: Colors.white,),
        Icon(Icons.edit, color: Colors.white,),
      ], 
      inactiveIcons: [
        Text("My", style: TextStyle(color: Colors.white),),
        Text("Home", style: TextStyle(color: Colors.white),),
        Text("Edit", style: TextStyle(color: Colors.white),)
      ], 
      color: Colors.black,
      height: 60,
      circleWidth: 60,
      activeIndex: activeIndex,
      onTap: onTap,
      );
  }
}