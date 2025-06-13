import 'package:freezed_annotation/freezed_annotation.dart';

part 'alignment_types.freezed.dart';

@freezed
@JsonSerializable()
class AlignmentEntry with _$AlignmentEntry {
  const AlignmentEntry({
    required this.startA,
    required this.endA,
    required this.startB,
    required this.endB,
    required this.seqA,
    required this.data,
    required this.seqB,
  });

  @override
  final int startA;

  @override
  final int endA;

  @override
  final int startB;

  @override
  final int endB;

  @override
  final String seqA;

  @override
  final String data;

  @override
  final String seqB;

  factory AlignmentEntry.fromJson(Map<String, Object?> json) => AlignmentEntry(
        startA: json['startA'] as int,
        endA: json['endA'] as int,
        startB: json['startB'] as int,
        endB: json['endB'] as int,
        seqA: json['seqA'] as String,
        data: json['data'] as String,
        seqB: json['seqB'] as String,
      );
}

@freezed
@JsonSerializable()
class NeedleResult with _$NeedleResult {
  const NeedleResult({
    required this.forward,
    required this.backward,
  });

  @override
  final List<AlignmentEntry> forward;

  @override
  final List<AlignmentEntry> backward;

  factory NeedleResult.fromJson(Map<String, Object?> json) => NeedleResult(
        forward: (json['forward'] as List<dynamic>)
            .map((e) => AlignmentEntry.fromJson(e as Map<String, Object?>))
            .toList(),
        backward: (json['backward'] as List<dynamic>)
            .map((e) => AlignmentEntry.fromJson(e as Map<String, Object?>))
            .toList(),
      );
}
