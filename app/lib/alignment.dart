import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'alignment_types.dart';

part 'alignment.g.dart';

@riverpod
Future<NeedleResult> runNeedle(Ref ref, String a, String b) async {
  final resp = await http.post(
    //Uri.parse('http://localhost:8080/align'),
    Uri.parse('https://api.beebs.dev/align'),
    headers: {'Content-Type': 'application/json'},
    encoding: utf8,
    body: jsonEncode({
      'gapopen': 10.0,
      'gapextend': 0.5,
      'endopen': 10.0,
      'endextend': 0.5,
      'seqa': a,
      'seqb': b,
    }),
  );
  if (resp.statusCode != 200) {
    throw Exception('failed to run needle: ${resp.statusCode}');
  }
  return NeedleResult.fromJson(jsonDecode(resp.body));
}
