import 'package:car_stax/components/car_list_builder.dart';
import 'package:flutter/material.dart';


class CarListPage extends StatefulWidget {
  const CarListPage({super.key});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarListBuilder()
          ],
        ),
      ),
    );
  }
}
