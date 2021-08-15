import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();
  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf Of Wall Street",
    "Interstellar",
    "Game Of Thrones",
    "Vikings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Stack(
            children: [
              movieCard(movieList[index], context),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ],
          );
        },
        itemCount: movieList.length,
      ),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.white),
                        ),
                      ),
                      Text('Rating:  ${movie.imdbRating} / 10',
                          style: mainTextStyle()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Released:  ${movie.released} ',
                          style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieListViewDetails(
                    movieName: movie.title,
                    movie: movie,
                  )),
        );
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 15.0, color: Colors.grey);
  }

  Widget movieImage(String imgUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
      ),
    );
  }
}

class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails(
      {Key? key, required this.movieName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0],),
          MovieDetailsHeaderWithPoster(movie: movie,),
          HorizontalLine(),
          MovieDetailsCast(movie: movie,),
          HorizontalLine(),
          MovieDetailsExtraPosters(posters: movie.images,)


        ],
      ),
      // body: Container(
      //   child: Center(
      //     child: ElevatedButton(
      //       child: Text('Go Back ${this.movieName}'),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
      Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(thumbnail),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Icon(Icons.play_circle_outline,size: 100,color: Colors.white,),
      ],
    ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00f5f5f5),Color(0xFFf5f5f5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 80,
        ),

      ],
    );
  }
}
class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderWithPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster:movie.images[0].toString()),
          SizedBox(width: 16,),
          MovieDetailsHeader(movie:movie),

        ],
      ),
    );
  }
}
class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${movie.year}  . ${movie.genre} '.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.cyan,
            ),

          ),
          Text(
            movie.title ,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 33,
            ),

          ),
          Text.rich(TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(text: movie.plot),
              TextSpan(text: 'More..',style: TextStyle(color: Colors.indigoAccent)),

            ],
          ),),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
 final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius=BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}
class MovieDetailsCast extends StatelessWidget {

  final Movie movie;

  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field:"Cast",value:movie.actors),
          MovieField(field:"Directors",value:movie.director),
          MovieField(field:"Awards",value:movie.awards),
        ],
      ),
    );
  }
}
class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field : ',
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w300
          ),
        ),
        Expanded(
           child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300
            ),
          ),
        ),

      ],
    );
  }
}
class HorizontalLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
      child: Container(
        height: .5,
        color: Colors.grey,
      ),
    );
  }
}


class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String>posters;

  const MovieDetailsExtraPosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            'More Movie Posters '.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black26
            ),
          ),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              separatorBuilder:(context,index)=> SizedBox(width: 8.0,),
              itemCount: posters.length,
            itemBuilder: (context,index)=>ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 160,
                width: MediaQuery.of(context).size.width/4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(posters[index]),
                    fit: BoxFit.cover
                  ),
                ),
              ),
            )
          ),
        ),
      ],
    );
  }
}
