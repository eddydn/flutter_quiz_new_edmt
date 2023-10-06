import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/screens/home_page.dart';
import 'package:flutter_quiz_new_edmt/screens/question_detail_page.dart';
import 'package:flutter_quiz_new_edmt/screens/read_mode_page.dart';
import 'package:flutter_quiz_new_edmt/screens/test_mode_page.dart';
import 'package:flutter_quiz_new_edmt/screens/text_result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/homePage": (context) => const HomePage(),
        "/readMode": (context) => const ReadModePage(),
        "/testMode": (context) => const TestModePage(),
        "/testResult": (context) => const TestResultPage(),
        "/questionDetail": (context) => const QuestionDetailPage()
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      await Future.delayed(const Duration(seconds: 3));
      if (!context.mounted) return;
      Navigator.of(context).pop();
      Navigator.pushNamed(context, "/homePage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
