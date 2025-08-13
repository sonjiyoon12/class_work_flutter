import 'package:class_google_map_v1/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShardPreferences 예제',
      debugShowCheckedModeBanner: false,
      home: CountStorage(),
    );
  }
}

class CountStorage extends StatefulWidget {
  const CountStorage({super.key});

  @override
  State<CountStorage> createState() => _CountStorageState();
}

class _CountStorageState extends State<CountStorage> {
  int _counter = 0;
  final String _counterKey = "count_value";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('예제 학습'),
        backgroundColor: Colors.orange[300],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            // 새로 고침 -> 저장되어 있는 값을 다시 불러주세요
            onPressed: _loadData,
            icon: Icon(Icons.refresh),
            tooltip: '데이터 새로 고침',
          ),
          IconButton(
            onPressed: () async {
              // Shp.. 값을 0 으로 처리 코드
              // 모든 키를 삭제 하는 코드
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(_counterKey); // 키 삭제 처리
              // 화면도 초기화
              setState(() {
                _counter = 0;
              });
              _showMessage("모든 데이터 삭제 완료");
            },
            icon: Icon(Icons.delete_forever),
            tooltip: '모든 데이터 삭제',
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.green[400],
        child: Text(
          textAlign: TextAlign.center,
          '팁: 앱을 종료했다가 다시 실행해보세요\n저장한 값이 그대로 남아 있을거에요',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Column _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Colors.blue[100],
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Text(
                '카운터',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.orange[100], shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    '${_counter}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_counter > 0) {
                          _counter -= 1;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
                    ),
                    child: Text(
                      '-1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter += 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                    ),
                    child: Text(
                      '+1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveCounter,
                  label: Text('저장하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // SharedPreferences - 비동기 동작 한다.
  Future<void> _saveCounter() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // 현재 카운터 값 저장하는 방법
      bool success = await prefs.setInt(_counterKey, _counter);
      if (success == true) {
        print("카운터 값 저장 성공 : $_counter");
        _showMessage('카운터 값이 저장이 되었습니다');
      } else {
        _showMessage('카운터 값 저장 중 오류');
      }
    } catch (e) {
      _showMessage('카운터 값 저장 중 오류');
    }
  }

  Future<void> _loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final int savedCounter = prefs.getInt(_counterKey) ?? 0;
      setState(() {
        _counter = savedCounter;
      });
    } catch (e) {
      _showMessage('카운터 값 저장 중 오류');
    }
  }

  // 사용자에게 메세지 보여주기
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
