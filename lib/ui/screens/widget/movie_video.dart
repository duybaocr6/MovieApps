import 'package:flutter/material.dart';
import '../../../utils/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieVideo extends StatefulWidget {
  final String movieId;
  const MovieVideo({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieVideo> createState() => _MovieVideoState();
}

class _MovieVideoState extends State<MovieVideo> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? Center(
            child: SpinKitFadingCircle(
              color: accentBackgroundColor,
              size: 20,
            ),
          )
        : YoutubePlayer(
            controller: _controller!,
            progressColors: ProgressBarColors(
              handleColor: primaryBackgroundColor,
              playedColor: primaryBackgroundColor,
            ),
            onEnded: (YoutubeMetaData meta) {
              _controller!.play();
              _controller!.pause();
            },
          );
  }
}
