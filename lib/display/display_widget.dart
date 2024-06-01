import 'package:tailorapp_assignment/insertdataModel.dart';
import 'package:tailorapp_assignment/mongoDB_model.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'display_model.dart';
export 'display_model.dart';

class DisplayWidget extends StatefulWidget {
  const DisplayWidget({super.key});

  @override
  State<DisplayWidget> createState() => _DisplayWidgetState();
}

class _DisplayWidgetState extends State<DisplayWidget> {
  // late DisplayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => DisplayModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    // _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            'Display',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: MongoService.fetchData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print(totalData.toString());
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return displayCard(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return Center(
                  child: Text("No Data Available"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("${data.id.$oid}"),
            SizedBox(height: 5),
            Text("${data.name}"),
            SizedBox(height: 5),
            Text("${data.password}"),
          ],
        ),
      ),
    );
  }
}
