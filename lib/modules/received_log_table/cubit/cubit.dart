import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illa_logging_app/models/received_logs/received_logs.dart';
import 'package:illa_logging_app/modules/received_log_table/cubit/states.dart';
import 'package:illa_logging_app/shared/theme/theme.dart';

final List<MovieModel> list =[];
class ReceivedLogsCubit extends Cubit<ReceivedLogsStates>{
  ReceivedLogsCubit() : super(ReceivedLogsLoadingState());
  static ReceivedLogsCubit get(context) => BlocProvider.of(context);

  int pageNumber = 1;
  getData() async {

    try{
      for(int pageNumber = 1; pageNumber < 2; pageNumber++){
        Response response = await Dio().get('https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=$pageNumber');
        var model = MoviesData.fromJson(response.data);
        list.addAll(model.list);
      }

      // if (model.list.isNotEmpty){
      //   pageNumber++;
      //
      // }
      emit(ReceivedLogsSuccessState());
    } on DioException catch (error){
      emit(ReceivedLogsFailedState());
    }

  }

  bool isLightTheme = true;
  changeTheme(){
    isLightTheme = !isLightTheme;
    print(isLightTheme);
    emit(ReceivedLogsChangeThemeState());
  }

}

class MoviesData {
  late final int page, totalPages, totalResults;
  late final List<MovieModel> list;

  MoviesData.fromJson(Map<String, dynamic> json){
    page = json['page'];
    list = List.from(json['results']).map((e)=>MovieModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}


