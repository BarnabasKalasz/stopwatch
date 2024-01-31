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
    final theme = Theme.of(context);

    /// Reverse the order of laps list to display freshest lap time at the top
    List<int> reversedLaps = laps.reversed.toList();
    return SizedBox(
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Lap Times:',
                  style: TextStyle(
                    color: theme.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (reversedLaps.isEmpty)
              const Text('No laps recorded')
            else
              SizedBox(
                height: 210,
                child: ListView.builder(
                  itemCount: reversedLaps.length,
                  itemBuilder: (context, index) {
                    final lapTime = reversedLaps[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.surface,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                            'Lap ${reversedLaps.length - index}: ${formatTime(lapTime)}',
                            style: TextStyle(color: theme.colorScheme.primary)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: theme.colorScheme.secondary,
                          ),
                          onPressed: () =>
                              onClear(reversedLaps.length - index - 1),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ));
  }
}
