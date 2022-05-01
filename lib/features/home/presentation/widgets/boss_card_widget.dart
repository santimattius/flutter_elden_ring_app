import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_template/features/home/domain/entities/bosse.dart';

import 'loading_widget.dart';

class BossCard extends StatefulWidget {
  final Boss boss;

  const BossCard(
    this.boss, {
    Key key,
  }) : super(key: key);

  @override
  _BossCardState createState() => _BossCardState();
}

class _BossCardState extends State<BossCard> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.boss.image,
              placeholder: (context, url) => LoadingWidget(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Author: ${widget.boss.name}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
