import 'item.dart';

class Model<T> {
  T? data;

  Model.getMovieList(dynamic item) {
    data = (item).map((element) => MovieItem.fromJson(element)).toList();
  }
}
