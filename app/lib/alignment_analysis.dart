import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oligotool/alignment_types.dart';
import 'package:oligotool/seq_alignment.dart';
import 'alignment.dart';

class AlignmentAnalysis extends StatefulWidget {
  final String seqA;
  final String seqB;

  const AlignmentAnalysis({super.key, required this.seqA, required this.seqB});

  @override
  State<AlignmentAnalysis> createState() => _AlignmentAnalysisState();
}

class _AlignmentAnalysisState extends State<AlignmentAnalysis> {
  Widget _buildResult(
    BuildContext context,
    AlignmentEntry a, {
    bool backward = false,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichSeq(
                    seq: a.seqA,
                    startIndex: a.startA,
                    endIndex: a.endA,
                    forwards: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 28),
                      OverlapData(data: a.data),
                    ],
                  ),
                  RichSeq(
                    seq: a.seqB,
                    startIndex: a.startB,
                    endIndex: a.endB,
                    forwards: !backward,
                    preferBelow: true,
                  ),
                ]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(runNeedleProvider(widget.seqA, widget.seqB));
        switch (result) {
          case AsyncLoading():
            return const Center(child: CircularProgressIndicator());
          case AsyncError():
            return Center(child: Text('Error: ${result.error}'));
          case AsyncData(:final value):
            final forwardAlignments = value.forward;
            final backwardAlignments = value.backward;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...forwardAlignments.map((a) => _buildResult(context, a)),
                  ...backwardAlignments.map(
                    (a) => _buildResult(context, a, backward: true),
                  ),
                ],
              ),
            );
        }
        ;
      },
    );
  }
}

class OverlapData extends StatelessWidget {
  final String data;

  const OverlapData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Row(
          children: data.split('').map((c) {
        return Container(
          width: 18.5,
          height: 12,
          child: Center(
            child: c == ' '
                ? Container()
                : c == '|'
                    ? Container(
                        color: Colors.white,
                        width: 1,
                        height: 16,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(128),
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                        width: 3,
                        height: 3,
                      ),
          ),
        );
      }).toList()),
    );
  }
}
