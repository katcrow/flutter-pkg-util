import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/src/home/data/repository/sql_sample_crud_repo.dart';
import '../../../utils/data_util.dart';
import '../data/model/sample_model.dart';
import 'home_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> createdRandomSample() async {
    double value = DataUtils.randomValue();
    // info : 1. 모델(data)에 담고
    var sampleModel = SampleModel(
      name: DataUtils.makeUuid(),
      isYn: value % 2 == 0,
      value: value,
      createdAt: DateTime.now(),
    );

    // info : 2. data 를 repository 에 넘겨서 sqflite 에 저장
    await SqlSampleCrudRepo.create(sampleModel);
    update();
  }

  void update() => setState(() {});

  Future<List<SampleModel>> _loadSampleList() async {
    return await SqlSampleCrudRepo.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqflite Sample'),
      ),
      body: FutureBuilder<List<SampleModel>>(
          future: _loadSampleList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Not support sqflite'),
              );
            } else if (snapshot.hasData) {
              var allDatas = snapshot.data;
              return ListView(
                children: List.generate(
                    allDatas!.length, (index) => _sampleOne(allDatas[index])),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: createdRandomSample,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _sampleOne(SampleModel sampleModel) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                HomeDetailScreen(sample: sampleModel),
          ),
        );
        update();
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sampleModel.isYn ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 7),
                Text(sampleModel.name),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              sampleModel.createdAt.toIso8601String(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
