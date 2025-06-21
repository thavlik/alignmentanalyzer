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
    required this.alignments,
    required this.stdout,
    required this.stderr,
  });

  @override
  final List<AlignmentEntry> alignments;

  @override
  final String stdout;

  @override
  final String stderr;

  factory NeedleResult.fromJson(Map<String, Object?> json) => NeedleResult(
        alignments: (json['alignments'] as List<dynamic>)
            .map((e) => AlignmentEntry.fromJson(e as Map<String, Object?>))
            .toList(),
        stdout: json['stdout'] as String,
        stderr: json['stderr'] as String,
      );
}

@freezed
@JsonSerializable()
class NeedleOutput with _$NeedleOutput {
  const NeedleOutput({
    required this.forward,
    required this.backward,
  });

  @override
  final NeedleResult forward;

  @override
  final NeedleResult backward;

  factory NeedleOutput.fromJson(Map<String, Object?> json) => NeedleOutput(
        forward: NeedleResult.fromJson(json['forward'] as Map<String, Object?>),
        backward:
            NeedleResult.fromJson(json['backward'] as Map<String, Object?>),
      );
}
