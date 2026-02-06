class DummyMovie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final String language;
  final List<String> genres;

  const DummyMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.language,
    required this.genres,
  });
}

/// Repository for dummy movie data
class DummyMovieData {
  // Private constructor to prevent instantiation
  DummyMovieData._();

  static List<DummyMovie> getMovies() {
    return _movies;
  }

  static final List<DummyMovie> _movies = [
    const DummyMovie(
      id: 1,
      title: 'The Shawshank Redemption',
      posterPath:
          'https://via.placeholder.com/300x450/1a1a1a/ffffff?text=Shawshank',
      overview:
          'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
      releaseDate: '1994-09-23',
      voteAverage: 8.7,
      voteCount: 24500,
      language: 'en',
      genres: ['Drama', 'Crime'],
    ),
    const DummyMovie(
      id: 2,
      title: 'The Godfather',
      posterPath:
          'https://via.placeholder.com/300x450/1a1a1a/ffffff?text=Godfather',
      overview:
          'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      releaseDate: '1972-03-14',
      voteAverage: 8.7,
      voteCount: 18300,
      language: 'en',
      genres: ['Crime', 'Drama'],
    ),
    const DummyMovie(
      id: 3,
      title: 'The Dark Knight',
      posterPath:
          'https://via.placeholder.com/300x450/1a1a1a/ffffff?text=Dark+Knight',
      overview:
          'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.',
      releaseDate: '2008-07-18',
      voteAverage: 9.0,
      voteCount: 31200,
      language: 'en',
      genres: ['Action', 'Crime', 'Drama'],
    ),
    const DummyMovie(
      id: 4,
      title: 'Pulp Fiction',
      posterPath:
          'https://via.placeholder.com/300x450/1a1a1a/ffffff?text=Pulp+Fiction',
      overview:
          'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
      releaseDate: '1994-10-14',
      voteAverage: 8.5,
      voteCount: 26700,
      language: 'en',
      genres: ['Crime', 'Thriller'],
    ),
    const DummyMovie(
      id: 5,
      title: 'Forrest Gump',
      posterPath:
          'https://via.placeholder.com/300x450/1a1a1a/ffffff?text=Forrest+Gump',
      overview:
          'The presidencies of Kennedy and Johnson unfold through the perspective of an Alabama man with an IQ of 75.',
      releaseDate: '1994-07-06',
      voteAverage: 8.8,
      voteCount: 25900,
      language: 'en',
      genres: ['Drama', 'Romance'],
    ),
    const DummyMovie(
      id: 6,
      title: 'Inception',
      posterPath:
          'https://via.placeholder.com/300x450/1a1a1a/ffffff?text=Inception',
      overview:
          'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea.',
      releaseDate: '2010-07-16',
      voteAverage: 8.8,
      voteCount: 33400,
      language: 'en',
      genres: ['Action', 'Sci-Fi', 'Thriller'],
    ),
  ];
}
