import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/entities/bosse.dart';

import 'loading_widget.dart';

class BossCard extends StatefulWidget {
  final Boss boss;

  const BossCard(
    this.boss, {
    Key? key,
  }) : super(key: key);

  @override
  _BossCardState createState() => _BossCardState();
}

class _BossCardState extends State<BossCard> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: widget.boss.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => LoadingWidget(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/camera.png',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.boss.name),
            ),
          )
        ],
      ),
    );
  }
}
