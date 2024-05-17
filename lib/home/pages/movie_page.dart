import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/database/database.dart';
import '../../core/utils/get_image_url.dart';
import '../controller/home_controller.dart';
import '../repository/movie_repository.dart';
import '../widgets/movie_card.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key, required this.movie});
  final Movie movie;

  final controller = MovieController(MovieRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: controller.getMovieDetails(movie.id ?? 0),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final details = snapshot.data;
          return SingleChildScrollView(
            // width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: getImageUrl(details?.backdropPath ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              details?.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateTime.parse(details?.releaseDate ?? '')
                                .year
                                .toString(),
                          ),
                        ],
                      ),
                      Builder(builder: (context) {
                        String text = '${details?.runtime} | ';

                        text = text +=
                            (details?.genres?.map((e) => e.name).join(', ') ??
                                '');
                        return Text(text);
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                          future: controller.getSimilarMovies(
                              movieId: movie.id ?? 0),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return SizedBox(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: MovieCard(
                                      movie: snapshot.data[index],
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MoviePage(
                                              movie: snapshot.data[index]);
                                        }));
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        details?.overview ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
