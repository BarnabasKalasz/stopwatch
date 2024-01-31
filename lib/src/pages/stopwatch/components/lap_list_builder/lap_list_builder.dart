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
    // Reverse the order of laps list to display freshest lap time at the top
    List<int> reversedLaps = laps.reversed.toList();
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
            if (reversedLaps.isEmpty)
              const Text('No laps recorded')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: reversedLaps.length,
                  itemBuilder: (context, index) {
                    final lapTime = reversedLaps[index];
                    return ListTile(
                      title: Text(
                          'Lap ${reversedLaps.length - index}: ${formatTime(lapTime)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () =>
                            onClear(reversedLaps.length - index - 1),
                      ),
                    );
                  },
                ),
              ),
          ],
        ));
  }
}
