import 'package:flutter/material.dart';
import 'package:flutterworld/models/webtoon_model.dart';
import 'package:flutterworld/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final WebtoonModel webtoon;

  const Webtoon({super.key, required this.webtoon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              webtoon: webtoon,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: webtoon.id,
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
                webtoon.thumb,
                headers: const {
                  'Referer': 'https://comic.naver.com',
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            webtoon.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
