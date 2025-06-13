import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oligotool/alignment_view.dart';
import 'bioutil.dart';

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
        brightness: Brightness.dark,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Oligo Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const String _kFontFamily = 'Courier New';

List<dynamic> colorizeDNA(String seq) {
  List<dynamic> coloredSeq = [];
  for (int i = 0; i < seq.length; i++) {
    String base = seq[i];
    String color = colorForBaseText(base);
    coloredSeq.add({
      'insert': base,
      'attributes': {
        'color': color,
        'font': _kFontFamily,
      },
    });
  }
  coloredSeq.add({'insert': '\n'});
  return coloredSeq;
}

class _MyHomePageState extends State<MyHomePage> {
  final seq1 = 'CCGGTATATCAGTCAGTCAGTC';
  final seq2 = 'CAGTCAGTCAGATCGGGACTATAGCAG';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ProviderScope(
        child: AlignmentView(),
      ),
    );
  }
}
