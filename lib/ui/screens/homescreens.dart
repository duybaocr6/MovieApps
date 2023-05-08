import 'package:flutter/material.dart';
import '../../ui/screens/widget/movie_category.dart';
import '../../ui/screens/widget/movie_card.dart';
import '../../reponsitories/data_reponsitories.dart';
// import '../services/api_services.dart';
import 'package:provider/provider.dart';
// import '../../models/movie.dart';
import '../../utils/constant.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: accentBackgroundColor,
      appBar: AppBar(
        backgroundColor: accentBackgroundColor,
        leading: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUgB6-bw4VFvfhVL-QcNfUMWU_2ocRksqVqQ&usqp=CAU',
          fit: BoxFit.cover,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            label: 'Popular Movie',
            movieList: dataProvider.popularMovieList,
            imageHeight: 160,
            imageWidth: 110,
            callback: dataProvider.getPopularMovie,
          ),
          MovieCategory(
            label: 'Trending Movie',
            movieList: dataProvider.topRated,
            imageHeight: 200,
            imageWidth: 150,
            callback: dataProvider.getTopRated,
          ),
          MovieCategory(
            label: 'Just netflix',
            movieList: dataProvider.upComing,
            imageHeight: 160,
            imageWidth: 110,
            callback: dataProvider.getUpComing,
          ),
        ],
      ),
    );
  }
}
