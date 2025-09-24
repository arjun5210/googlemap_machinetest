import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:testmachineproject/model/food_model.dart';
import 'package:testmachineproject/model/fooddetails_model.dart';
import 'package:testmachineproject/model/product_model.dart';
import 'package:testmachineproject/model/site_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});

    on<FetchSites>((event, emit) async {
      emit(SiteLoading());
      try {
        final response = await http.get(
          Uri.parse("https://admin.thereback.com.au/api/getSites"),
        );

        if (response.statusCode == 200) {
          final jsonBody = jsonDecode(response.body);

          final List<dynamic> data = jsonBody['data'];

          final List<Site> sites = data.map((e) => Site.fromJson(e)).toList();

          emit(SiteLoaded(sites));
        } else {
          emit(SiteError("Failed to fetch data"));
        }
      } catch (e) {
        emit(SiteError(e.toString()));
      }
    });
    on<getproducts>((event, emit) async {
      emit(getloading());
      try {
        String url = "https://fakestoreapi.com/products";
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          print(response.statusCode);
          List data = jsonDecode(response.body);
          var result = data.map((e) => productdetails.fromjson(e)).toList();
          print(result);
          emit(getloaded(data: result));
        }
      } catch (e) {
        emit(geterror(error: e.toString()));
      }
    });

    on<getfooddetails>((event, emit) async {
      emit(foodloading());
      try {
        String url =
            "https://www.themealdb.com/api/json/v1/1/filter.php?c=Chicken";
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var data = await jsonDecode(response.body);
          List meals = data['meals'];

          print(response.body);

          var datadetails = meals.map((e) => fooddetails.fromjson(e)).toList();
          print(datadetails);
          emit(foodloaded(details: datadetails));
        }
      } catch (e) {
        emit(foodderror(error: e.toString()));
      }
    });
    on<getfooddata>((event, emit) async {
      emit(foodloading());
      try {
        String url =
            "https://www.themealdb.com/api/json/v1/1/lookup.php?i=${event.id}";
        var response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['meals'] != null) {
            List meals = data['meals'];

            var datadetails = meals
                .map((e) => fooddetailsmodel.fromjson(e))
                .toList();

            emit(fooddetailsloaded(details: datadetails));
          } else {
            emit(foodderror(error: "Nofound"));
          }
        } else {
          emit(foodderror(error: e.toString()));
        }
      } catch (e) {
        emit(foodderror(error: e.toString()));
      }
    });
  }
}
