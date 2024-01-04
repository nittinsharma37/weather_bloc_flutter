import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        print("hey im here ");
        WeatherFactory wf = WeatherFactory(dotenv.env['API_KEY']!, language: Language.ENGLISH); 
       
        
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude
        );
        print("weather here  ------ >>>> $weather");
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
        
      }
    });
  }
}
