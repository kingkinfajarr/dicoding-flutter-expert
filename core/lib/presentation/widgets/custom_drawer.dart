import 'package:about/about.dart';
import 'package:flutter/material.dart';

import '../pages/tv_series/home_tvseries_page.dart';
import '../pages/tv_series/watchlist_tv_page.dart';
import '../pages/watchlist_movies_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('Tv Series'),
          onTap: () {
            Navigator.pushNamed(
              context,
              HomeTvSeriesPage.ROUTE_NAME,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist Movie'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist Tv'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    );
  }
}
