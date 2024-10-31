import 'package:flutter/material.dart';
import 'package:flutterworld/models/webtoon_model.dart';

class DetailScreen extends StatelessWidget {
  final WebtoonModel webtoon;
  const DetailScreen({
    super.key,
    required this.webtoon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          webtoon.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ],
      ),
    );
  }
}
