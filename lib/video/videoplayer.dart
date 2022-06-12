import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoPlay extends StatefulWidget {
  const videoPlay(
      {Key? key, required this.videoPlayerController, required this.isLoop})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final bool isLoop;
  @override
  State<videoPlay> createState() => _videoPlayState();
}

class _videoPlayState extends State<videoPlay> {
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
        looping: widget.isLoop,
        aspectRatio: widget.videoPlayerController.value.aspectRatio,
        autoInitialize: true,
        videoPlayerController: widget.videoPlayerController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(controller: _chewieController),
    );
  }
}

class videoDisplay extends StatefulWidget {
  final String videoUrl;
  const videoDisplay({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<videoDisplay> createState() => _videoDisplayState();
}

class _videoDisplayState extends State<videoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: videoPlay(
          videoPlayerController: VideoPlayerController.network(widget.videoUrl),
          isLoop: false),
    );
  }
}
