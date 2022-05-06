import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/bloc/home_bosses_bloc.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/bloc/home_bosses_event.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/bloc/home_bosses_state.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_elden_ring_app/injection_container.dart';

class HomePage extends StatelessWidget {
  static const _PAGE_TITLE = 'Elden Ring';
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_onScroll(context));
    return Scaffold(
      appBar: AppBar(
        title: Text(_PAGE_TITLE),
      ),
      body: buildBody(context),
    );
  }

  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => sl<HomeBossesBloc>(),
        child: BlocBuilder<HomeBossesBloc, HomeState>(
          builder: (context, state) {
            return currentStateWidget(context, state);
          },
        ),
      ),
    );
  }

  Widget currentStateWidget(BuildContext context, HomeState state) {
    if (state is Init) {
      BlocProvider.of<HomeBossesBloc>(context).add(GetBossesEvent());
      return Container();
    } else if (state is Empty) {
      return MessageDisplay(
        message: 'No result available!',
      );
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Loaded) {
      final bosses = state.bosses;
      return ListView.builder(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          shrinkWrap: true,
          physics: _scrollPhysics,
          itemCount: bosses.length,
          itemBuilder: (BuildContext context, int index) {
            return BossCard(bosses[index]);
          });
    } else if (state is Error) {
      return MessageDisplay(
        message: state.message,
      );
    } else {
      return Container();
    }
  }

  ScrollPhysics get _scrollPhysics {
    return ClampingScrollPhysics();
  }

  VoidCallback _onScroll(BuildContext context) {
    if (_isBottom(context))
      BlocProvider.of<HomeBossesBloc>(context).add(FetchBosses());
  }

  bool _isBottom(BuildContext context) {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final double height = MediaQuery.of(context).size.height;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
