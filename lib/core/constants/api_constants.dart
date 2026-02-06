class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  // TMDB API Credentials
  static const String apiKey = 'd30cc88bc0168c4e5a9385783eb9fe3f';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMzBjYzg4YmMwMTY4YzRlNWE5Mzg1NzgzZWI5ZmUzZiIsInN1YiI6IjYyYmU3YjE1MjhiZTViMDA2NmNmMTRiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.F7g4uNFIbBDnp1BYqZfPz3WF5GlxXnCFgaWKZ8z0Kq0';

  // API Endpoints
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  // Image Sizes
  static const String posterW500 = '$imageBaseUrl/w500';
  static const String backdropW780 = '$imageBaseUrl/w780';
  static const String profileW185 = '$imageBaseUrl/w185';
}
