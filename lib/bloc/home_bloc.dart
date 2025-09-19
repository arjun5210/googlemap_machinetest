import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
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
  }
}
