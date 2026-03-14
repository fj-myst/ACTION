import 'package:flutter/material.dart';

class RecentsWidget extends StatefulWidget {
  final void Function(Map<String, dynamic> draft) onEditDraft; // <-- add this

  const RecentsWidget({super.key, required this.onEditDraft});

  @override
  State<RecentsWidget> createState() => _RecentsWidgetState();
}

class _RecentsWidgetState extends State<RecentsWidget> {
  final List<Map<String, dynamic>> _drafts = [
    {
      "title": "IT Orientation",
      "venue": "RITO Office",
      "date": DateTime(2026, 3, 18, 9, 0),
      "uniform": "Business Casual",
    },
    {
      "title": "Budget Planning",
      "venue": "Conference Room",
      "date": DateTime(2026, 3, 22, 10, 0),
      "uniform": "Class A",
    },
    {
      "title": "Network Setup Briefing",
      "venue": "Camp Vicente Lim",
      "date": DateTime(2026, 3, 25, 14, 0),
      "uniform": "Class B",
    },
    {
      "title": "Q2 Review Draft",
      "venue": "Conference Room",
      "date": DateTime(2026, 4, 1, 8, 0),
      "uniform": "Class A",
    },
  ];

  final List<Map<String, dynamic>> _posted = [
    {
      "title": "Flag Ceremony",
      "venue": "Camp Vicente Lim",
      "date": DateTime(2026, 3, 2, 8, 0),
      "uniform": "Class B",
    },
    {
      "title": "Cybersecurity Workshop",
      "venue": "RITO Office",
      "date": DateTime(2026, 3, 3, 13, 0),
      "uniform": "Business Casual",
    },
    {
      "title": "Team Meeting",
      "venue": "Conference Room",
      "date": DateTime(2026, 3, 4, 9, 0),
      "uniform": "Class B",
    },
    {
      "title": "Extra Event",
      "venue": "Lobby",
      "date": DateTime.now(),
      "uniform": "Class B",
    },
  ];

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, ${date.year}  $hour:$minute $ampm';
  }

  // Tap on card = view dialog
  void _viewAnnouncement(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(item['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Venue: ${item['venue']}"),
            Text("Date: ${_formatDate(item['date'])}"),
            Text("Uniform: ${item['uniform']}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // Edit = push CreateAnnouncementPage with draft data prefilled
  void _editDraft(Map<String, dynamic> draft) {
    widget.onEditDraft(draft);
  }

  void _deleteItem(List<Map<String, dynamic>> list, int index) {
    final title = list[index]['title'];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Announcement"),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() => list.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('"$title" deleted.')));
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _announcementCard({
    required Map<String, dynamic> item,
    required int index,
    required List<Map<String, dynamic>> list,
    required bool isDraft,
  }) {
    return GestureDetector(
      onTap: () => _viewAnnouncement(item), // <-- whole card tappable
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isDraft
                    ? const Color(0xFFFFF3CD)
                    : const Color(0xFFD4EDDA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isDraft ? "Draft" : "Posted",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDraft
                      ? const Color(0xFF856404)
                      : const Color(0xFF155724),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              item['title'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.location_on, size: 13, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item['venue'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 13, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _formatDate(item['date']),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(Icons.checkroom, size: 13, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item['uniform'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // Action buttons — stop tap propagation so they don't trigger the card's onTap
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _editDraft(item),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: Colors.orange,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _deleteItem(list, index),
                  behavior: HitTestBehavior.opaque,
                  child: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required String label,
    required List<Map<String, dynamic>> list,
    required bool isDraft,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        if (list.isEmpty)
          Text(
            isDraft ? "No drafts yet." : "No posted announcements.",
            style: const TextStyle(color: Colors.grey),
          )
        else
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              list.length,
              (i) => _announcementCard(
                item: list[i],
                index: i,
                list: list,
                isDraft: isDraft,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(label: "DRAFTS", list: _drafts, isDraft: true),
          const SizedBox(height: 40),
          _section(label: "POSTED", list: _posted, isDraft: false),
        ],
      ),
    );
  }
}
