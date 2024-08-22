import 'package:flutter/material.dart';
import 'package:illa_logging_app/modules/received_log_table/cubit/cubit.dart';

class ReceivedLogs extends DataTableSource{

  final List<MovieModel> movies;
  final void Function({
    required String title,
    required String overview,
    required String image,
    required int? voteAverage,
  }) onRowSelected;

  ReceivedLogs(this.movies, {required this.onRowSelected});

  @override
  //building each row inside the table
  DataRow? getRow(int index) {
    if (index >= movies.length) return null;
    final movie = movies[index];
    return DataRow(
      onSelectChanged: (selected){
        if (selected != null && selected) {
          // Pass movie details to the callback when the row is selected
          onRowSelected(
              title: movie.title,
              voteAverage: movie.voteAverage!.round(),
              image: movie.posterPath,
              overview: movie.overview);
        }
      },
      cells: [
      //building each cell inside the row
      //cell for title
      DataCell(
        Container(
          width: 200,
          child: Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      //cell for rate
      DataCell(
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow[700],
              size: 15,
            ),
            Text(' ${movie.voteAverage!.round()}'),
          ],
        ),
      ),
      //cell for overview
      DataCell(
        Container(
          width: double.infinity,
          child: Text(
            movie.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // Limit text to a maximum of 3 lines
          ),
        ),
      ),
    ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => list.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class MovieModel {
  late final bool adult;
  late final String backdropPath;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final double? voteAverage;
  late final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath = "http://image.tmdb.org/t/p/original${json['backdrop_path']}" == null? "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png" : "http://image.tmdb.org/t/p/original${json['backdrop_path']}";
    //genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = double.parse(json['popularity'].toString());
    posterPath = "http://image.tmdb.org/t/p/original${json['poster_path']}"==null? "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png" : "http://image.tmdb.org/t/p/original${json['poster_path']}";
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = double.parse(json['vote_average'].toString());
    voteCount = json['vote_count'];
  }
}