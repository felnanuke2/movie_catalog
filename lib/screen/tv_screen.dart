import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/controller/profile_controller.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/moviescreen/model/actor_model.dart';
import 'package:movie_catalog/moviescreen/model/movie_video_model.dart';
import 'package:movie_catalog/moviescreen/widget/cast_avatar_item.dart';
import 'package:movie_catalog/tvscreen/controler/tv_controler.dart';
import 'package:movie_catalog/tvscreen/models/tv_model.dart';
import 'package:movie_catalog/user/user_controller.dart';
import 'package:movie_catalog/user/usermodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:rive/rive.dart' as rive;

class TVScreen extends StatefulWidget {
  MovieItemModel? movieItemModel;
  UniqueKey? _uniqueKey;
  TVScreen(this.movieItemModel, this._uniqueKey);

  @override
  _TVScreenState createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> with TickerProviderStateMixin {
  var initiated = false;
  var _controller = TvController();
  TvModel? tvModel;
  bool expandedOverview = false;
  bool expandVideoGrid = false;
  Animation<double>? _arrowDownAnimation;
  AnimationController? _animationController;
  rive.Artboard? _riveArtBoard;
  bool isLiked = false;
  bool wachList = false;
  bool rated = false;
  final _meditype = 'tv';
  final _starController = StreamController<num>.broadcast();
  num starCount = 0.5;
  @override
  void initState() {
    super.initState();
    _controller.getData(widget.movieItemModel!.id.toString());
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowDownAnimation = Tween<double>(begin: 0, end: 0.5)
        .animate(CurvedAnimation(parent: _animationController!, curve: Curves.linearToEaseOut));
    rootBundle.load('assets/favorite Button.riv').then((value) {
      final file = rive.RiveFile.import(value);
      final artB = file.mainArtboard;
      _riveArtBoard = artB;
      setState(() {
        _riveArtBoard!.addController(rive.SimpleAnimation(!isLiked ? 'unlike' : 'like'));
      });
    });
    if (UserModel.instance.baseUser != null) {
      isLiked = ProfileController.tvFavorites
          .map((e) => e.id)
          .toList()
          .contains(widget.movieItemModel!.id!);
      wachList = ProfileController.tvWhactList
          .map((e) => e.id)
          .toList()
          .contains(widget.movieItemModel!.id!);
      rated =
          ProfileController.tvRated.map((e) => e.id).toList().contains(widget.movieItemModel!.id!);
      if (rated) {
        var item = ProfileController.tvRated
            .firstWhere((element) => element.id == widget.movieItemModel!.id!);
        starCount = item.rating!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: StreamBuilder<TvModel>(
          stream: _controller.tvStream,
          initialData: _controller.tvModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              tvModel = snapshot.data;
            }
            return CustomScrollView(
              slivers: [
                _buildSliverAppBarWithImage(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        _buildTitle(),
                        if (UserModel.instance.baseUser != null) _optionsRowUser(context),
                        SizedBox(
                          height: 10,
                        ),
                        if (tvModel != null) _buildCategorys(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildStarsRow(),
                        SizedBox(
                          height: 10,
                        ),
                        if (tvModel != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Temporadas: ${tvModel!.numberOfSeasons}',
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Episódios: ${tvModel!.numberOfEpisodes}',
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (tvModel != null)
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Duração dos Episódios: ${tvModel!.episodeRunTime}m',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        if (tvModel != null)
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Lançamento: ${tvModel!.firstAirDate}',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildOverViewContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildCastingGridView(),
                        SizedBox(
                          height: 10,
                        ),
                        _videosGridView(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSimilar(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  Row _optionsRowUser(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: BACKGROUND_COLOR,
          ),
          child: InkWell(
            onTap: () {
              _riveArtBoard!.addController(rive.SimpleAnimation(isLiked ? 'unlike' : 'like'));
              isLiked = !isLiked;
              UserController.markAsFavorite(isLiked, _meditype, widget.movieItemModel!);
            },
            child: _riveArtBoard != null
                ? rive.Rive(artboard: _riveArtBoard!)
                : Icon(
                    Icons.favorite,
                    color: Color(0xffef47b6),
                  ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: wachList ? BACKGROUND_COLOR : Colors.white,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                wachList = !wachList;
                UserController.addToWatchList(wachList, _meditype, widget.movieItemModel!);
              });
            },
            child: Icon(
              Icons.bookmark,
              color: wachList ? Colors.red : BACKGROUND_COLOR,
              size: 28,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: rated ? BACKGROUND_COLOR : Colors.white,
          ),
          child: InkWell(
            onTap: () {
              _starRateGesture(context);
            },
            child: Icon(
              Icons.star,
              color: rated ? Colors.amber : BACKGROUND_COLOR,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  _starRateGesture(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          backgroundColor: Colors.black.withOpacity(0.01),
          content: Row(
            children: [
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  var position = details.localPosition.dx;
                  if (position > 100) position = 100;
                  if (position < 5) position = 5;
                  starCount = position / 10;
                  var string = starCount.toStringAsFixed(2);

                  if (string.contains('.')) {
                    var splited = string.split('.');
                    var first = splited.first;
                    var last = splited.last;
                    var value = num.parse(last);
                    var rest = 0;
                    if (value > 50 && value < 70) value = 50;
                    if (value < 50 && value > 30) value = 50;
                    if (value < 30) {
                      value = 0;
                    }
                    if (value > 70) {
                      value = 0;
                      rest += 1;
                    }

                    starCount = int.parse(first) + rest + (value / 100);
                  }
                  _starController.add(starCount);
                },
                onHorizontalDragEnd: (details) {
                  Navigator.pop(context, true);
                },
                child: StreamBuilder<num>(
                    stream: _starController.stream,
                    initialData: starCount,
                    builder: (context, snapshot) {
                      var white = 10 - snapshot.data!.round();
                      return ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                                  colors: List.generate(snapshot.data!.round(),
                                          (index) => Color(Colors.amber.value)) +
                                      List.generate(white, (index) => Colors.white))
                              .createShader(bounds);
                        },
                        child: Row(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: 8,
              ),
              StreamBuilder<num>(
                  stream: _starController.stream,
                  initialData: starCount,
                  builder: (context, snapshot) {
                    return Text(
                      '${starCount.toStringAsFixed(1)} / 10.0',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  })
            ],
          ),
        );
      },
    );
    if (result == true) {
      setState(() {
        rated = true;
        UserController.rateSerie(widget.movieItemModel!, num.parse(starCount.toStringAsFixed(1)));
      });
    }
  }

  StreamBuilder<List<MovieItemModel>> _buildSimilar() {
    return StreamBuilder<List<MovieItemModel>>(
      stream: _controller.similarListStream,
      initialData: _controller.similarTVList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data!.isEmpty) return Container();
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Similares',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 340,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => MovieItem(
                  snapshot.data![index],
                  tv: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  StreamBuilder<CreditModel> _buildCastingGridView() {
    return StreamBuilder<CreditModel>(
        stream: _controller.creditStream,
        initialData: _controller.creditModel,
        builder: (context, snapshotActors) {
          if (snapshotActors.data == null) return Container();
          var actorsList = snapshotActors.data!.cast!;
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Elenco',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.count(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 8,
                childAspectRatio: 3 / 4,
                crossAxisCount: 5,
                children: List.generate(actorsList.length >= 10 ? 10 : actorsList.length,
                    (index) => Container(child: CastAvatarItem(actorsList[index]))),
              ),
            ],
          );
        });
  }

  InkWell _buildOverViewContainer() {
    return InkWell(
      onTap: () {
        setState(() {
          expandedOverview = !expandedOverview;
        });
      },
      child: Center(
        child: Text(
          widget.movieItemModel!.overview!,
          maxLines: expandedOverview ? null : 4,
          overflow: expandedOverview ? null : TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
        ),
      ),
    );
  }

  Row _buildStarsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: List.generate(
                    5, (index) => Icon(Icons.star_border_outlined, color: Colors.grey)),
              ),
              Row(
                children: _buildStars(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          widget.movieItemModel!.voteAverage!.toStringAsFixed(1),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  StreamBuilder<List<MovieVideoModel>> _videosGridView() {
    return StreamBuilder<List<MovieVideoModel>>(
      stream: _controller.videosStream,
      initialData: _controller.videoList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data!.isEmpty) return Container();
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Videos',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GridView.count(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 16 / 9,
              children: List.generate(
                  expandVideoGrid
                      ? snapshot.data!.length
                      : snapshot.data!.length > 4
                          ? 4
                          : snapshot.data!.length, (index) {
                var videoItem = snapshot.data![index];
                var imageUr = 'https://img.youtube.com/vi/${videoItem.key}/0.jpg';
                return InkWell(
                  onTap: () => _showDialogVideo(context, videoItem.key!),
                  child: Hero(
                    tag: videoItem.key!,
                    child: Image.network(
                      imageUr,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            if (snapshot.data!.length > 4)
              Center(
                  child: IconButton(
                onPressed: () {
                  setState(() {
                    expandVideoGrid = !expandVideoGrid;
                    if (_animationController!.isCompleted) {
                      _animationController!.reverse();
                    } else {
                      _animationController!.forward();
                    }
                  });
                },
                icon: RotationTransition(
                  turns: _arrowDownAnimation!,
                  child: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              )),
          ],
        );
      },
    );
  }

  _showDialogVideo(BuildContext context, String videoId) {
    var _controller =
        YoutubePlayerController(initialVideoId: videoId, flags: YoutubePlayerFlags(autoPlay: true));
    var _player = YoutubePlayer(controller: _controller);

    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.black.withOpacity(0.4),
              insetAnimationDuration: Duration(milliseconds: 400),
              insetPadding: EdgeInsets.all(0),
              child: Hero(
                tag: videoId,
                child: YoutubePlayerBuilder(
                  player: _player,
                  builder: (context, player) {
                    return player;
                  },
                ),
              ),
            ));
  }

  List<Widget> _buildStars() {
    String _voteAvagare = (widget.movieItemModel!.voteAverage! / 2).toString();
    int _voteRate = 0;
    int? _voteRateRest;
    if (_voteAvagare.toString().contains('.')) {
      var splitedAverage = _voteAvagare.split('.');
      _voteRate = int.parse(splitedAverage[0]);
      _voteRateRest = num.parse(splitedAverage[1]).round();
    } else {
      _voteRate = int.parse(_voteAvagare);
    }
    if (_voteRateRest != null) {
      _voteRate += 1;
    }

    return List.generate(_voteRate, (index) {
      if (_voteRateRest != null) {
        if (index == _voteRate - 1) return Icon(Icons.star_half_outlined, color: Colors.amber);
      }
      return Icon(Icons.star, color: Colors.amber);
    });
  }

  Widget _buildCategorys() {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: List.generate(
          tvModel!.genres!.length,
          (index) => Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  tvModel!.genres![index].name!,
                  style: TextStyle(color: Colors.white),
                ),
              )),
    );
  }

  Center _buildTitle() {
    return Center(
      child: Text(
        widget.movieItemModel!.title!,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  StreamBuilder _buildSliverAppBarWithImage(BuildContext context) {
    return StreamBuilder<List>(
        stream: _controller.videosStream,
        initialData: _controller.videoList,
        builder: (context, snapshot1) {
          return StreamBuilder<CreditModel>(
              stream: _controller.creditStream,
              initialData: _controller.creditModel,
              builder: (context, snapshot2) {
                return StreamBuilder<TvModel>(
                    stream: _controller.tvStream,
                    initialData: _controller.tvModel,
                    builder: (context, snapshot3) {
                      return StreamBuilder<List<MovieItemModel>>(
                          stream: _controller.similarListStream,
                          initialData: _controller.similarTVList,
                          builder: (context, snapshot4) {
                            bool conenctAwait = snapshot1.data!.isEmpty &&
                                snapshot2.data == null &&
                                snapshot3.data == null;

                            return SliverAppBar(
                              expandedHeight: (MediaQuery.of(context).size.width / 2) * 3,
                              backgroundColor: Colors.transparent,
                              pinned: true,
                              flexibleSpace: Hero(
                                tag: widget._uniqueKey!,
                                child: AspectRatio(
                                  aspectRatio: 2 / 3.2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2${widget.movieItemModel!.posterPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                if (conenctAwait)
                                  Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            );
                          });
                    });
              });
        });
  }
}
