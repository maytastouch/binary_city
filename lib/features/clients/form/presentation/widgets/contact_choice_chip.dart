import 'package:binary_city/core/common/entities/contact_entity.dart';
import 'package:flutter/material.dart';

class ContactChoiceChip extends StatefulWidget {
  final ContactEntity contact;
  final List<String> selectedContactIDs;
  final Function(String, bool) onSelectionChanged;

  const ContactChoiceChip({
    super.key,
    required this.contact,
    required this.selectedContactIDs,
    required this.onSelectionChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ContactChoiceChipState createState() => _ContactChoiceChipState();
}

class _ContactChoiceChipState extends State<ContactChoiceChip> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedContactIDs.contains(widget.contact.id);
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ChoiceChip(
        avatar: isSelected ? const Icon(Icons.check, size: 20.0) : null,
        label: Text('${widget.contact.firstName} ${widget.contact.lastName}'),
        selected: isSelected,
        onSelected: (bool selected) {
          widget.onSelectionChanged(widget.contact.id, selected);
        },
        backgroundColor: Colors.transparent,
        selectedColor: Colors.blue.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected
                ? Colors.blue
                : Colors.grey, // Adjust color based on your theme
            width: 1,
          ),
        ),
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : Colors.black, // Adjust color based on your theme
          fontSize: 14, // Adjust font size based on your theme
        ),
      ),
    );
  }
}
