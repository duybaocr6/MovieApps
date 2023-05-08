import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/api_services.dart';

import '../models/movie.dart';

class DataRepository with ChangeNotifier {
  final APIServices apiServices = APIServices();
  final List<Movie> _popularMovieList = [];
  final List<Movie> _topRated = [];
  final List<Movie> _upComing = [];
  int _popularMoviePageIndex = 1;
  int _topRatedPageIndex = 1;
  int _upComingPageIndex = 1;

  //getter
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get topRated => _topRated;
  List<Movie> get upComing => _upComing;

  Future<void> getPopularMovie() async {
    try {
      List<Movie> movie = await apiServices.getPopularMovies(
          pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movie);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (e) {
      print("Error: ${e.statusCode}");
      rethrow;
    }
  }

  Future<void> getTopRated() async {
    try {
      List<Movie> movie =
          await apiServices.getTopRated(pageNumber: _topRatedPageIndex);
      _topRated.addAll(movie);
      _topRatedPageIndex++;
      notifyListeners();
    } on Response catch (e) {
      print("Error: ${e.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpComing() async {
    try {
      List<Movie> movie =
          await apiServices.getUpComing(pageNumber: _upComingPageIndex);
      _upComing.addAll(movie);
      _upComingPageIndex++;
      notifyListeners();
    } on Response catch (e) {
      print("Error: ${e.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      Movie newMovie = await apiServices.getMovieDetails(movie: movie);
      newMovie = await apiServices.getMovieVideos(movie: newMovie);
      newMovie = await apiServices.getMovieCasting(movie: newMovie);
      newMovie = await apiServices.getMovieImage(movie: newMovie);
      return newMovie;
    } on Response catch (e) {
      print("Error: ${e.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await Future.wait([
      getPopularMovie(),
      getTopRated(),
      getUpComing(),
    ]);
  }
}
