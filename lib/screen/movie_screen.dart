import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/controller/profile_controller.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/moviescreen/controler/movie_screen_controller.dart';
import 'package:movie_catalog/moviescreen/model/actor_model.dart';
import 'package:movie_catalog/moviescreen/model/movie_model_detailed.dart';
import 'package:movie_catalog/moviescreen/model/movie_video_model.dart';
import 'package:movie_catalog/moviescreen/widget/cast_avatar_item.dart';
import 'package:movie_catalog/user/user_controller.dart';
import 'package:movie_catalog/user/usermodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:rive/rive.dart' as rive;

class MovieScreen extends StatefulWidget {
  MovieItemModel? _movieItemModel;
  UniqueKey? _uniqueKey;

  MovieScreen(this._movieItemModel, this._uniqueKey);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with TickerProviderStateMixin {
  var _movieControler = MovieScreenController();
  MovieModelDetail? _movieModelDetail;
  bool expandVideoGrid = false;
  bool expandedOverview = false;
  Animation<double>? _arrowDownAnimation;
  AnimationController? _animationController;
  rive.Artboard? _riveArtBoard;
  bool isLiked = false;
  bool wachList = false;
  bool rated = false;
  final _meditype = 'movie';
  final _starController = StreamController<num>.broadcast();
  num starCount = 0.5;

  @override
  initState() {
    Future.delayed(Duration(milliseconds: 350))
        .then((value) => _movieControler.getData(widget._movieItemModel!.id!.toString()));
    super.initState();
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
      isLiked = ProfileController.movieFavorites
          .map((e) => e.id)
          .toList()
          .contains(widget._movieItemModel!.id!);
      wachList = ProfileController.movieWhactList
          .map((e) => e.id)
          .toList()
          .contains(widget._movieItemModel!.id!);
      rated = ProfileController.movieRated
          .map((e) => e.id)
          .toList()
          .contains(widget._movieItemModel!.id!);
      if (rated) {
        var item = ProfileController.movieRated
            .firstWhere((element) => element.id == widget._movieItemModel!.id!);
        starCount = item.rating!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBarWithImage(context),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitle(),
                    if (UserModel.instance.baseUser != null) _optionsRowUser(context),
                    SizedBox(
                      height: 10,
                    ),
                    _buildCategorys(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildStarsRow(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildMoviesDetail(),
                    _buildDirector(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StreamBuilder<MovieModelDetail>(
                        initialData: _movieControler.movieModelDetail,
                        stream: _movieControler.movieDetailStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Text(
                            'Lançamento: ${snapshot.data!.releaseDate}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildOverViewContainer(),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elenco',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
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
        ));
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
              UserController.markAsFavorite(isLiked, _meditype, widget._movieItemModel!);
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
                UserController.addToWatchList(wachList, _meditype, widget._movieItemModel!);
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
        UserController.rateMovie(widget._movieItemModel!, num.parse(starCount.toStringAsFixed(1)));
      });
    }
  }

  StreamBuilder<List<MovieItemModel>> _buildSimilar() {
    return StreamBuilder<List<MovieItemModel>>(
      stream: _movieControler.recomendationsStream,
      initialData: _movieControler.recomendationsList,
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
                itemBuilder: (context, index) => MovieItem(snapshot.data![index]),
              ),
            ),
          ],
        );
      },
    );
  }

  StreamBuilder<List<MovieVideoModel>> _videosGridView() {
    return StreamBuilder<List<MovieVideoModel>>(
      stream: _movieControler.listVideosStream,
      initialData: _movieControler.listVideoModel,
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
              ))
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

  Align _buildDirector() {
    return Align(
      alignment: Alignment.centerLeft,
      child: StreamBuilder<CreditModel>(
        stream: _movieControler.movieCreditStream,
        initialData: _movieControler.creditModel,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          var director =
              snapshot.data!.crew!.firstWhere((element) => element.job == 'Director').name;
          return Text(
            'Diretor: $director',
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
        },
      ),
    );
  }

  StreamBuilder<MovieModelDetail> _buildMoviesDetail() {
    return StreamBuilder<MovieModelDetail>(
        stream: _movieControler.movieDetailStream,
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          _movieModelDetail = snapshot.data!;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_movieModelDetail!.runtime != null)
                    Expanded(
                      child: Text(
                        'Duração: ${_getTimeFormated(_movieModelDetail!.runtime!)}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Receita: \$ ${(_movieModelDetail!.revenue! / 1000000).round()} M',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Título Original: ${_movieModelDetail!.originalTitle}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          );
        });
  }

  String _getTimeFormated(int time) {
    var converted = time / 60;
    if (converted.toString().contains('.')) {
      var splitedTime = converted.toStringAsFixed(2).split('.');
      var hours = splitedTime[0];
      var minuts = ((num.parse(splitedTime[1]) / 100) * 60).round();
      return '${hours}h ${minuts}m';
    } else {
      return converted.toString() + 'h';
    }
  }

  Center _buildTitle() {
    return Center(
      child: Text(
        widget._movieItemModel!.title!,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  StreamBuilder _buildSliverAppBarWithImage(BuildContext context) {
    return StreamBuilder<List>(
        stream: _movieControler.listVideosStream,
        initialData: _movieControler.listVideoModel,
        builder: (context, snapshot1) {
          return StreamBuilder<CreditModel>(
              stream: _movieControler.movieCreditStream,
              initialData: _movieControler.creditModel,
              builder: (context, snapshot2) {
                return StreamBuilder<MovieModelDetail>(
                    stream: _movieControler.movieDetailStream,
                    initialData: _movieControler.movieModelDetail,
                    builder: (context, snapshot3) {
                      return StreamBuilder<List<MovieItemModel>>(
                          stream: _movieControler.recomendationsStream,
                          initialData: _movieControler.recomendationsList,
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
                                      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2${widget._movieItemModel!.posterPath}',
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

  StreamBuilder<CreditModel> _buildCastingGridView() {
    return StreamBuilder<CreditModel>(
        stream: _movieControler.movieCreditStream,
        initialData: _movieControler.creditModel,
        builder: (context, snapshotActors) {
          if (snapshotActors.data == null) return Container();
          var actorsList = snapshotActors.data!.cast!;
          return GridView.count(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 8,
            childAspectRatio: 3 / 4,
            crossAxisCount: 5,
            children: List.generate(actorsList.length >= 10 ? 10 : actorsList.length,
                (index) => Container(child: CastAvatarItem(actorsList[index]))),
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
          widget._movieItemModel!.overview!,
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
          widget._movieItemModel!.voteAverage!.toStringAsFixed(1),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  StreamBuilder<MovieModelDetail> _buildCategorys() {
    return StreamBuilder<MovieModelDetail>(
        stream: _movieControler.movieDetailStream,
        initialData: null,
        builder: (context, snapshotDetailed) {
          if (!snapshotDetailed.hasData) return Container();
          return Wrap(
            spacing: 2,
            runSpacing: 2,
            children: List.generate(
                snapshotDetailed.data!.genres!.length,
                (index) => Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        snapshotDetailed.data!.genres![index].name!,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
          );
        });
  }

  List<Widget> _buildStars() {
    String _voteAvagare = (widget._movieItemModel!.voteAverage! / 2).toString();
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
}
