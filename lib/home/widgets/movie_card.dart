import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movies_app/home/controller/home_controller.dart';
import 'package:movies_app/home/models/movie.dart';
import 'package:movies_app/home/pages/movie_page.dart';
import 'package:movies_app/home/repository/movie_repository.dart';

class MovieCard extends StatelessWidget {
  MovieCard({super.key, required this.movie, this.onTap});
  final Movie movie;
  final Function()? onTap;

  final controller = MovieController(MovieRepository());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    controller.getImageUrl(imagePath: movie.posterPath ?? ''),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  movie.releaseDate ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Text(
            '${movie.title}\n',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
