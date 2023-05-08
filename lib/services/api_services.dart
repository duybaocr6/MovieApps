import 'package:dio/dio.dart';
import '../models/person.dart';
import '../models/movie.dart';

import '../services/api.dart';

class APIServices {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // on construct Url
    String _url = api.baseURL + path;
    //on construct parameter
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'en-US',
    };
    // check params exist or not
    if (params != null) {
      query.addAll(params);
    }
    //on response
    final response = await dio.get(_url, queryParameters: query);
    //check response
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getTopRated({required int pageNumber}) async {
    Response response = await getData('/movie/top_rated', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpComing({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();
      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'],
      );
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> videoKeys = _data['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();

      return movie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCasting({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<Person> _casting = _data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();

      return movie.copyWith(casting: _casting);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieImage({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/images', params: {
      'include_image_language': 'null',
    });
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> images = _data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();

      return movie.copyWith(images: images);
    } else {
      throw response;
    }
  }
}
