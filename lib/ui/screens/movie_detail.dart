import 'package:flutter/material.dart';
import '../../ui/screens/widget/movie_image.dart';
import '../../ui/screens/widget/person_casting.dart';
import '../../ui/screens/widget/movie_video.dart';
import '../../ui/screens/widget/action_button.dart';
import '../../ui/screens/widget/movie_info.dart';
import '../../utils/constant.dart';
import '../../reponsitories/data_reponsitories.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentBackgroundColor,
      appBar: AppBar(
        backgroundColor: accentBackgroundColor,
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(
                color: primaryBackgroundColor,
                size: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: newMovie!.videos!.isEmpty
                        ? Center(
                            child: Text(
                              'This is not exist video',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : MovieVideo(movieId: newMovie!.videos!.first),
                  ),
                  MovieInfo(movie: newMovie!),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    bgColor: Colors.white,
                    color: accentBackgroundColor,
                    icon: Icons.play_arrow,
                    label: 'Lecture',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    bgColor: Colors.grey.withOpacity(0.3),
                    color: Colors.white,
                    icon: Icons.download,
                    label: 'Download video',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    newMovie!.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Casting',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        itemCount: newMovie!.casting!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return newMovie!.casting![index].imageURL == null
                              ? const Center()
                              : PersonCasting(
                                  person: newMovie!.casting![index]);
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Gallery',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: newMovie!.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return MovieImage(
                              posterPath: newMovie!.images![index]);
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
