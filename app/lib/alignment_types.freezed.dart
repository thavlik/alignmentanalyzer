// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alignment_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlignmentEntry {
  int get startA;
  int get endA;
  int get startB;
  int get endB;
  String get seqA;
  String get data;
  String get seqB;

  /// Create a copy of AlignmentEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AlignmentEntryCopyWith<AlignmentEntry> get copyWith =>
      _$AlignmentEntryCopyWithImpl<AlignmentEntry>(
          this as AlignmentEntry, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AlignmentEntry &&
            (identical(other.startA, startA) || other.startA == startA) &&
            (identical(other.endA, endA) || other.endA == endA) &&
            (identical(other.startB, startB) || other.startB == startB) &&
            (identical(other.endB, endB) || other.endB == endB) &&
            (identical(other.seqA, seqA) || other.seqA == seqA) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.seqB, seqB) || other.seqB == seqB));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startA, endA, startB, endB, seqA, data, seqB);

  @override
  String toString() {
    return 'AlignmentEntry(startA: $startA, endA: $endA, startB: $startB, endB: $endB, seqA: $seqA, data: $data, seqB: $seqB)';
  }
}

/// @nodoc
abstract mixin class $AlignmentEntryCopyWith<$Res> {
  factory $AlignmentEntryCopyWith(
          AlignmentEntry value, $Res Function(AlignmentEntry) _then) =
      _$AlignmentEntryCopyWithImpl;
  @useResult
  $Res call(
      {int startA,
      int endA,
      int startB,
      int endB,
      String seqA,
      String data,
      String seqB});
}

/// @nodoc
class _$AlignmentEntryCopyWithImpl<$Res>
    implements $AlignmentEntryCopyWith<$Res> {
  _$AlignmentEntryCopyWithImpl(this._self, this._then);

  final AlignmentEntry _self;
  final $Res Function(AlignmentEntry) _then;

  /// Create a copy of AlignmentEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startA = null,
    Object? endA = null,
    Object? startB = null,
    Object? endB = null,
    Object? seqA = null,
    Object? data = null,
    Object? seqB = null,
  }) {
    return _then(AlignmentEntry(
      startA: null == startA
          ? _self.startA
          : startA // ignore: cast_nullable_to_non_nullable
              as int,
      endA: null == endA
          ? _self.endA
          : endA // ignore: cast_nullable_to_non_nullable
              as int,
      startB: null == startB
          ? _self.startB
          : startB // ignore: cast_nullable_to_non_nullable
              as int,
      endB: null == endB
          ? _self.endB
          : endB // ignore: cast_nullable_to_non_nullable
              as int,
      seqA: null == seqA
          ? _self.seqA
          : seqA // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      seqB: null == seqB
          ? _self.seqB
          : seqB // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$NeedleResult {
  List<AlignmentEntry> get alignments;
  String get stdout;
  String get stderr;

  /// Create a copy of NeedleResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NeedleResultCopyWith<NeedleResult> get copyWith =>
      _$NeedleResultCopyWithImpl<NeedleResult>(
          this as NeedleResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NeedleResult &&
            const DeepCollectionEquality()
                .equals(other.alignments, alignments) &&
            (identical(other.stdout, stdout) || other.stdout == stdout) &&
            (identical(other.stderr, stderr) || other.stderr == stderr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(alignments), stdout, stderr);

  @override
  String toString() {
    return 'NeedleResult(alignments: $alignments, stdout: $stdout, stderr: $stderr)';
  }
}

/// @nodoc
abstract mixin class $NeedleResultCopyWith<$Res> {
  factory $NeedleResultCopyWith(
          NeedleResult value, $Res Function(NeedleResult) _then) =
      _$NeedleResultCopyWithImpl;
  @useResult
  $Res call({List<AlignmentEntry> alignments, String stdout, String stderr});
}

/// @nodoc
class _$NeedleResultCopyWithImpl<$Res> implements $NeedleResultCopyWith<$Res> {
  _$NeedleResultCopyWithImpl(this._self, this._then);

  final NeedleResult _self;
  final $Res Function(NeedleResult) _then;

  /// Create a copy of NeedleResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alignments = null,
    Object? stdout = null,
    Object? stderr = null,
  }) {
    return _then(NeedleResult(
      alignments: null == alignments
          ? _self.alignments
          : alignments // ignore: cast_nullable_to_non_nullable
              as List<AlignmentEntry>,
      stdout: null == stdout
          ? _self.stdout
          : stdout // ignore: cast_nullable_to_non_nullable
              as String,
      stderr: null == stderr
          ? _self.stderr
          : stderr // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$NeedleOutput {
  NeedleResult get forward;
  NeedleResult get backward;

  /// Create a copy of NeedleOutput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NeedleOutputCopyWith<NeedleOutput> get copyWith =>
      _$NeedleOutputCopyWithImpl<NeedleOutput>(
          this as NeedleOutput, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NeedleOutput &&
            (identical(other.forward, forward) || other.forward == forward) &&
            (identical(other.backward, backward) ||
                other.backward == backward));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, forward, backward);

  @override
  String toString() {
    return 'NeedleOutput(forward: $forward, backward: $backward)';
  }
}

/// @nodoc
abstract mixin class $NeedleOutputCopyWith<$Res> {
  factory $NeedleOutputCopyWith(
          NeedleOutput value, $Res Function(NeedleOutput) _then) =
      _$NeedleOutputCopyWithImpl;
  @useResult
  $Res call({NeedleResult forward, NeedleResult backward});
}

/// @nodoc
class _$NeedleOutputCopyWithImpl<$Res> implements $NeedleOutputCopyWith<$Res> {
  _$NeedleOutputCopyWithImpl(this._self, this._then);

  final NeedleOutput _self;
  final $Res Function(NeedleOutput) _then;

  /// Create a copy of NeedleOutput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forward = null,
    Object? backward = null,
  }) {
    return _then(NeedleOutput(
      forward: null == forward
          ? _self.forward
          : forward // ignore: cast_nullable_to_non_nullable
              as NeedleResult,
      backward: null == backward
          ? _self.backward
          : backward // ignore: cast_nullable_to_non_nullable
              as NeedleResult,
    ));
  }
}

// dart format on
