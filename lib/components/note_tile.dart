import 'package:flutter/material.dart';
import 'package:flutter_geoff_notes_app/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTile(
      {super.key,
      required this.text,
      this.onEditPressed,
      this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: GestureDetector(
            onDoubleTap: () => showPopover(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.surface,
                bodyBuilder: (context) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 10, left: 25, right: 25, bottom: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(text, style: const TextStyle( fontFamily: 'Geneva' )),
                    )),
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle( fontFamily: 'Geneva' )
            )),
        trailing: Builder(builder: (context) {
          return IconButton(
              onPressed: () => showPopover(
                    width: 100,
                    height: 100,
                    context: context,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    bodyBuilder: (context) => NoteSettings(
                      onEditTap: onEditPressed,
                      onDeleteTap: onDeletePressed,
                    ),
                  ),
              icon: const Icon(Icons.more_vert));
        }),
      ),
    );
  }
}
