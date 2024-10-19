import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cubit/presentation/Screens/Recommenation_Doctor/logic/get_all_doc_cubit.dart';

import 'Widgets/DocWidget.dart';

class RecommendDoc extends StatelessWidget {
  const RecommendDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendation Doctor"),
      ),
      body: BlocProvider(
        create: (context) =>
        GetAllDocCubit()
          ..getAllDoc(),
        child: BlocBuilder<GetAllDocCubit, GetAllDocState>(
          builder: (context, state) {
            if (state is GetAllDocloading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllDocSuccess) {
              final doctors = state.doctors;
              return ListView.builder(
                itemBuilder: (context, index) {
                  // return Text("${doctors[index].name}");
                    return Docwidget(doctor: doctors[index]);
                },
                itemCount: doctors.length,
              );
            }
            else if (state is GetAllDocFailure) {
              return Center(child: Text("Failed to load doctors"));
            }
            return Container();
            // );
          },
        ),
      ),
    );
  }
}
