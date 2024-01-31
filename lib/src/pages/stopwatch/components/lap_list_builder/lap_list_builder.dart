import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/pages/stopwatch/utils/utilities.dart';

class LapList extends StatelessWidget {
  final List<int> laps;
  final Function(int) onClear;

  const LapList({
    Key? key,
    required this.laps,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lap Times:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (laps.isEmpty)
              const Text('No laps recorded')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: laps.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final lapTime = laps[index];
                    return ListTile(
                      title: Text('Lap ${index + 1}: ${formatTime(lapTime)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => onClear(index),
                      ),
                    );
                  },
                ),
              ),
          ],
        ));
  }
}
