import 'package:flutter/material.dart';
import 'package:oligotool/alignment_analysis.dart';

const aseq = 'ACGTACGCTATCATGCGTACGACCCCCCCACGCTATCCCCCCCCCCCCCTCTAGT';
const bseq = 'ACTAGCATGCCAGGTTACGTATACCGTGCGTATATATCCCCCCCCCCCTAGTCATG';

class AlignmentView extends StatefulWidget {
  const AlignmentView({
    super.key,
  });

  @override
  State<AlignmentView> createState() => _AlignmentViewState();
}

class _AlignmentViewState extends State<AlignmentView> {
  String seqA = aseq;
  String seqB = bseq;

  final controller = TextEditingController();

  Future<String?> _editSeq(BuildContext context, String seq) async {
    controller.text = seq;
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Sequence'),
          content: TextField(
            keyboardType: TextInputType.multiline,
            controller: controller,
            maxLines: null,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final r = await _editSeq(context, seqA);
            if (!mounted) return;
            if (r == null) return;
            setState(() => seqA = r);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              seqA,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontFamily: "Courier New"),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            final r = await _editSeq(context, seqB);
            if (!mounted) return;
            if (r == null) return;
            setState(() => seqB = r);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              seqB,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontFamily: "Courier New"),
            ),
          ),
        ),
        AlignmentAnalysis(
          seqA: seqA,
          seqB: seqB,
        ),
      ],
    );
  }
}
