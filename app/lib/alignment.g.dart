// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alignment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(runNeedle)
const runNeedleProvider = RunNeedleFamily._();

final class RunNeedleProvider extends $FunctionalProvider<
        AsyncValue<NeedleResult>, FutureOr<NeedleResult>>
    with $FutureModifier<NeedleResult>, $FutureProvider<NeedleResult> {
  const RunNeedleProvider._(
      {required RunNeedleFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'runNeedleProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$runNeedleHash();

  @override
  String toString() {
    return r'runNeedleProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<NeedleResult> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<NeedleResult> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
    );
    return runNeedle(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RunNeedleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$runNeedleHash() => r'e500ae2c8f8152cf5fb90c0a27a9913c9ca936d4';

final class RunNeedleFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<NeedleResult>,
            (
              String,
              String,
            )> {
  const RunNeedleFamily._()
      : super(
          retry: null,
          name: r'runNeedleProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  RunNeedleProvider call(
    String a,
    String b,
  ) =>
      RunNeedleProvider._(argument: (
        a,
        b,
      ), from: this);

  @override
  String toString() => r'runNeedleProvider';
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
