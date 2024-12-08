import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wibsite/saving_data/save_data.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Header(),
              SizedBox(height: 20),
              StepsCard(),
              SizedBox(height: 20),
              DailyActivityCard(),
              SizedBox(height: 20),
              WorkoutsCard(),
              SizedBox(height: 20),
              FoodTrackerCard(),
            ],
          ),
        ),
      ),
      //   bottomNavigationBar:
      //       const BottomNavBar(), // Keep this fixed to the bottom
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          radius: 25,
          child: Icon(Icons.account_circle, color: Colors.black),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Dabahne!',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Let\'s start your day',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[800], // Background color
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Icon(Icons.notifications, color: Color(0xFFb3ff00), size: 30),
          ),
        ),
      ],
    );
  }
}

class StepsCard extends StatelessWidget {
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d36),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Steps',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('11 000 / 16 000',
                  style: TextStyle(color: Colors.white)),
              Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF3a3a3c),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.68,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFb3ff00),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DailyActivityCard extends StatelessWidget {
  const DailyActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d36),
        borderRadius: BorderRadius.circular(35),
      ),
      // Remove fixed height, or keep it if you want a maximum height
      height: 220,
      child: Row(
        children: [
          Expanded(
            // Wrap the column in an Expanded widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Daily Activity',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                buildActivityRow('Steps', '11 000', '16 000'),
                buildActivityRow('Calories', '440', '680 Cal'),
                buildActivityRow('Water', '1.8', '2.5 L'),
              ],
            ),
          ),
          Expanded(
            // Use Expanded for the image to take remaining space
            child: SizedBox(
              // You can specify width for the gif if needed, height is now dynamic
              width: 200, // Set width for the gif image
              child: Image.asset(
                'assets/progress_bars.gif', // Replace with the path to your gif
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActivityRow(String label, String numerator, String denominator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: numerator,
                style: const TextStyle(
                    color: Color(0xFFd5ff5f),
                    fontSize: 20), // Larger font for numerator
              ),
              TextSpan(
                text: ' / $denominator',
                style: const TextStyle(
                    color: Color(0xFFd5ff5f),
                    fontSize: 16), // Smaller font for denominator
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkoutsCard extends StatelessWidget {
  const WorkoutsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d36),
        borderRadius: BorderRadius.circular(35),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Workouts', style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 10),
          WorkoutItem(
            icon: Icons.directions_walk,
            title: 'Indoor Walk',
            distance: '2.44 km',
            time: 'Today',
          ),
          WorkoutItem(
            icon: Icons.directions_run,
            title: 'Morning Running',
            distance: '3.88 km',
            time: 'Today',
          ),
        ],
      ),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String distance;
  final String time;

  const WorkoutItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.distance,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1e1e25),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          Icon(icon,
              color: const Color(0xFFd5ff5f),
              size: 30), // Changed to the new color
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white)),
                Text(distance,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class FoodTrackerCard extends StatelessWidget {
  const FoodTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d36),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Food',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('243 / 1 858 Cal',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFd5ff5f), // Changed to the new color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child:
                    const Text('Record', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Meal Tips',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          const MealTips(),
          const SizedBox(height: 10),
          const Text('See All',
              style: TextStyle(
                  color: Color(0xFFd5ff5f))), // Changed to the new color
        ],
      ),
    );
  }
}

class MealTips extends StatelessWidget {
  const MealTips({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MealTip(
          imageUrl:
              'https://storage.googleapis.com/a1aa/image/gnvoA41CfkUAbakxw34i8cgI5Y97vnHmf5TYVYr4COAZ6toTA.jpg',
          title: 'Roasted Shrimp Kale Salad with Grapefruit...',
          time: '30 min',
          calories: '626 Cal',
        ),
        MealTip(
          imageUrl:
              'https://storage.googleapis.com/a1aa/image/ZdquE3zzDSqNL1FK44NQSkCnbKixBJG2fzTZA75wpZbN9W0JA.jpg',
          title: 'Homemade Huevos Rancheros',
          time: '40 min',
          calories: '481 Cal',
        ),
      ],
    );
  }
}

class MealTip extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;
  final String calories;

  const MealTip(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.time,
      required this.calories});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3c),
        borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 160,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(35)),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.clock,
                              color: Colors.white, size: 12),
                          const SizedBox(width: 5),
                          Text(time,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.fire,
                              color: Colors.white, size: 12),
                          const SizedBox(width: 5),
                          Text(calories,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF2d2d36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.house, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.codeFork,
                color: Colors.white), // Meal icon
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.dumbbell,
                color: Color(0xFFc4ff00), size: 30),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.chartBar, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle,
                color: Colors.white), // Profile icon
          ),
        ],
      ),
    );
  }
}
