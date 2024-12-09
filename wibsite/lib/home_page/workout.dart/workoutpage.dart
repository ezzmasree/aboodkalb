import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wibsite/home_page/workout.dart/vidioplayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Map<String, String>> chestVideos = [];
  List<Map<String, String>> shoulderVideos = [];
  List<Map<String, String>> handsVideos = [];
  List<Map<String, String>> backVideos = [];
  List<Map<String, String>> legsVideos = [];
  List<Map<String, String>> trysibs = [];

  @override
  void initState() {
    super.initState();
    searchById("chest.email", 'chest');
    searchById("shoulder.email", 'shoulder');
    searchById("bicebs.email", 'hands');
    searchById("back.email", 'back');
    searchById("legs.email", 'legs');
    searchById("trysibs .email", 'trysibs');
  }

  void searchById(String id, String category) async {
    final url = Uri.parse('http://192.168.1.100:3000/pro/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['fitnes'] != null && data['fitnes'] is List) {
          setState(() {
            List<Map<String, String>> videoList = [];
            for (var video in data['fitnes']) {
              if (video.length >= 3) {
                videoList.add({
                  'id': video[0],
                  'title': video[1],
                  'description': video[2],
                });
              }
            }
            if (category == 'chest') {
              chestVideos = videoList;
            } else if (category == 'shoulder') {
              shoulderVideos = videoList;
            } else if (category == 'hands') {
              handsVideos = videoList;
            } else if (category == 'back') {
              backVideos = videoList;
            } else if (category == 'legs') {
              legsVideos = videoList;
            } else if (category == 'trysibs') {
              trysibs = videoList;
            }
          });
        } else {
          print('Invalid fitness data!');
        }
      } else {
        print('Product not found!');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget buildVideoSection(
      String title, List<Map<String, String>> videos, Color headerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap:
              true, // To prevent overflow when multiple categories are displayed
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];

            return Card(
              color: Colors.black,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(
                              videoId: video['id']!,
                              description: video['description']!,
                              title: video['title']!),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: video['id']!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Text(
                              //   video['description']!,
                              //   style: TextStyle(color: Colors.white),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD5FF5F),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Success"),
                            content: const Text("You added the item to your list."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      print(video['description']);
                    },
                    child: const Text(
                      'Add to My List',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 6, 12),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildVideoSection("Chest", chestVideos, Colors.red),
              buildVideoSection("Shoulder", shoulderVideos, Colors.blue),
              buildVideoSection("Bicebs", handsVideos, Colors.green),
              buildVideoSection(
                  "Trycibs", trysibs, const Color.fromARGB(255, 0, 195, 146)),
              buildVideoSection("Back", backVideos, Colors.orange),
              buildVideoSection("Legs", legsVideos, Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
