import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testmachineproject/bloc/home_bloc.dart';
import 'package:testmachineproject/view/googlemap_screen.dart';

class SiteScreen extends StatelessWidget {
  SiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => HomeBloc()..add(FetchSites()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text(
            "SITE DETAILS",
            style: GoogleFonts.aBeeZee(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is SiteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SiteLoaded) {
              return ListView.builder(
                itemCount: state.sites.length,
                itemBuilder: (context, index) {
                  final site = state.sites[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapScreen(
                              latitude: double.parse(site.latitude),
                              longitude: double.parse(site.longitude),
                              siteName: site.siteName,
                            ),
                          ),
                        );
                      },
                      child:
                          Container(
                            width: w * 0.2,
                            height: h * 0.4,

                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  ListTile(
                                    title: Text(
                                      "Site Name",
                                      style: GoogleFonts.manrope(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      site.siteName,
                                      style: GoogleFonts.manrope(fontSize: 18),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Site Description",
                                      style: GoogleFonts.manrope(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(site.description),
                                  ),

                                  ListTile(
                                    title: Text(
                                      "Latitude",
                                      style: GoogleFonts.manrope(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(site.latitude),
                                  ),

                                  ListTile(
                                    title: Text(
                                      "Longitude",
                                      style: GoogleFonts.manrope(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(site.longitude),
                                  ),
                                ],
                              ),
                            ),
                          ).animate().slide(
                            duration: 600.ms,
                            begin: const Offset(-1, 0),
                            end: const Offset(0, 0),
                            curve: Curves.easeOut,
                          ),
                    ),
                  );
                },
              );
            } else if (state is SiteError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Press button to load sites"));
          },
        ),
      ),
    );
  }
}
