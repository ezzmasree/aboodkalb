// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wibsite/home_page/workout.dart/fitnessTap.dart';
import 'package:wibsite/home_page/workout.dart/trainng.dart';
import 'package:wibsite/home_page/workout.dart/workoutpage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Define the Workout model
class Workout {
  final String title;
  final String imageUrl;
  final int duration;
  final String difficulty;
  final List<WorkoutVideo> videos;

  Workout({
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    required this.videos,
  });
}

// Define the WorkoutVideo model
class WorkoutVideo {
  final String title;
  final String videoUrl;

  WorkoutVideo({required this.title, required this.videoUrl});
}

class workout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: home(),
    );
  }
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: TabBar(
            tabs: [
              Tab(
                text: 'Workout-in',
                icon: Icon(
                    Icons.fitness_center), // Optional: Add an icon if needed
              ),
              Tab(
                text: 'Workout-out',
                icon: Icon(Icons.directions_run), // Optional: Add an icon
              ),
              Tab(
                text: 'Training',
                icon: Icon(Icons.accessibility_new), // Optional: Add an icon
              ),
            ],
            indicatorColor: Colors.white, // Tab indicator color
            indicatorWeight: 3.0, // Thickness of the tab indicator
            labelColor: Colors.green, // Color of the label when active
            unselectedLabelColor: const Color.fromARGB(
                179, 0, 0, 0), // Color of the label when inactive
            // ignore: prefer_const_constructors
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              fontSize: 16, // Font size of the active tab
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal, // Normal text for inactive tabs
            ),
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: 16.0), // Indicator padding
          ),
        ),
        body: TabBarView(
          children: [
            WorkoutPage(),
            FitnessTab(),
            Trainng(),
            // More tabs if needed
          ],
        ),
      ),
    );
  }
}
