import 'package:flutter/material.dart';
import 'package:movies_app/home/controller/home_controller.dart';
import 'package:movies_app/home/pages/movie_page.dart';
import 'package:movies_app/home/repository/movie_repository.dart';
import 'package:movies_app/home/widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = MovieController(MovieRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
      ),
      body: FutureBuilder(
        future: controller.getMovies(),
        builder: ((context, snapshot) {
          return GridView.builder(
            itemCount: snapshot.data?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.6,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: ((context, index) {
              return MovieCard(
                movie: snapshot.data![index],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MoviePage(movie: snapshot.data![index]);
                  }));
                },
              );
            }),
          );
        }),
      ),
    );
  }
}
