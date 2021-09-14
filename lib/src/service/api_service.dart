import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:movie/src/models/movie.dart';
import 'package:movie/src/models/search.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    // final dio = Dio(BaseOptions(
    //   validateStatus: (_) => true,
    // ));
    // dio.options.headers[""] = "";
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio, baseUrl: GlobalConfiguration().getValue('api_url'));
  }

  @GET("s={s}&plot=short")
  Future<Search> getSearch({
    @Path("s") String? search,
  });

  @GET("i={i}&t={t}&plot=short")
  Future<Movie> getSearchByIdOrTitle({
    @Path("i") String? id,
    @Path("t") String? title,
  });
}
