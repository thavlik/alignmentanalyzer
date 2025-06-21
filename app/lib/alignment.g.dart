// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alignment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(runNeedle)
const runNeedleProvider = RunNeedleFamily._();

final class RunNeedleProvider extends $FunctionalProvider<
        AsyncValue<NeedleOutput>, FutureOr<NeedleOutput>>
    with $FutureModifier<NeedleOutput>, $FutureProvider<NeedleOutput> {
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
  $FutureProviderElement<NeedleOutput> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<NeedleOutput> create(Ref ref) {
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

String _$runNeedleHash() => r'5dd8e13262cadff68b84782e3799ec828e1186ef';

final class RunNeedleFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<NeedleOutput>,
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
