import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/src/home/data/model/sample_model.dart';
import 'package:sqflite_tutorial/utils/data_util.dart';
import '../data/repository/sql_sample_crud_repo.dart';

class HomeDetailScreen extends StatefulWidget {
  final SampleModel sample;

  const HomeDetailScreen({Key? key, required this.sample}) : super(key: key);

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  // 1건 조회
  Future<SampleModel?> _loadSampleOne() async {
    return await SqlSampleCrudRepo.getSampleOne(widget.sample.id!);
  }

  // update
  Future<void> updateSampleOne(SampleModel data) async {
    double value = DataUtils.randomValue();
    var updateSample = data.clone(value: value, yn: value.toInt() % 2 == 0);
    await SqlSampleCrudRepo.updateSampleOne(updateSample);
    update();
  }

  // delete
  Future<void> deleteSampleOne(SampleModel data) async {
    await SqlSampleCrudRepo.deleteSampleOne(data.id!);
    Navigator.pop(context);
  }



  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sample.id.toString())),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<SampleModel?>(
            future: _loadSampleOne(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error Data : ${widget.sample.id}'),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text('No Data : ${widget.sample.id}'),
                );
              }

              var data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Name : ${data!.name}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Y/N : ${data.isYn}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'value : ${data.value}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'CreatedAt : ${data.createdAt}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        //
                        updateSampleOne(data);
                      },
                      child: const Text('Update Random Value')),
                  ElevatedButton(
                    onPressed: () {
                      deleteSampleOne(data);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete'),
                  )
                ],
              );
            }),
      ),
    );
  }
}
