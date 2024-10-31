import 'package:flutter/material.dart';
import 'package:flutterworld/models/webtoon_detail_model.dart';
import 'package:flutterworld/models/webtoon_episode_model.dart';
import 'package:flutterworld/models/webtoon_model.dart';
import 'package:flutterworld/services/api_service.dart';
import 'package:flutterworld/widgets/episode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;
  const DetailScreen({
    super.key,
    required this.webtoon,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> detail;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLikedToon = false;

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (likedToons.contains(widget.webtoon.id)) {
        setState(() {
          isLikedToon = true;
        });
      }
      return;
    }
    await prefs.setStringList("likedToons", []);
  }

  void onHeartTap() async {
    var likedToons = prefs.getStringList("likedToons");

    if (likedToons != null) {
      if (isLikedToon) {
        likedToons.remove(widget.webtoon.id);
      } else {
        likedToons.add(widget.webtoon.id);
      }

      prefs.setStringList("likedToons", likedToons);

      setState(() {
        isLikedToon = !isLikedToon;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    detail = ApiService.getToonDetailById(widget.webtoon.id);
    episodes = ApiService.getLatestEpisodesById(widget.webtoon.id);
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: isLikedToon
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.webtoon.id,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(10, 12),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      width: 250,
                      child: Image.network(
                        widget.webtoon.thumb,
                        headers: const {
                          'Referer': 'https://comic.naver.com',
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: detail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }

                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 40,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoonId: widget.webtoon.id,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
