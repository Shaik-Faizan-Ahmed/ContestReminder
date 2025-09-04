// @dart=3.6
// ignore_for_file: directives_ordering
// build_runner >=2.4.16
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:riverpod_generator/builder.dart' as _i2;
import 'package:source_gen/builder.dart' as _i3;
import 'package:mockito/src/builder.dart' as _i4;
import 'package:build_config/build_config.dart' as _i5;
import 'package:build_test/builder.dart' as _i6;
import 'dart:isolate' as _i7;
import 'package:build_runner/src/build_script_generate/build_process_state.dart'
    as _i8;
import 'package:build_runner/build_runner.dart' as _i9;
import 'dart:io' as _i10;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'riverpod_generator:riverpod_generator',
    [_i2.riverpodBuilder],
    _i1.toDependentsOf(r'riverpod_generator'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'source_gen:combining_builder',
    [_i3.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.apply(
    r'mockito:mockBuilder',
    [_i4.buildMocks],
    _i1.toDependentsOf(r'mockito'),
    hideOutput: false,
    defaultGenerateFor: const _i5.InputSet(include: [r'test/**']),
  ),
  _i1.apply(
    r'build_test:test_bootstrap',
    [
      _i6.debugIndexBuilder,
      _i6.debugTestBuilder,
      _i6.testBootstrapBuilder,
    ],
    _i1.toRoot(),
    hideOutput: true,
    defaultGenerateFor: const _i5.InputSet(include: [
      r'$package$',
      r'test/**',
    ]),
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i3.partCleanup,
  ),
];
void main(
  List<String> args, [
  _i7.SendPort? sendPort,
]) async {
  await _i8.buildProcessState.receive(sendPort);
  _i8.buildProcessState.isolateExitCode = await _i9.run(
    args,
    _builders,
  );
  _i10.exitCode = _i8.buildProcessState.isolateExitCode!;
  await _i8.buildProcessState.send(sendPort);
}
