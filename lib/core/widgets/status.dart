import 'package:flutter/material.dart';

class StatusDropdown extends StatefulWidget {
  final Function(String)? onChanged;

  const StatusDropdown({Key? key, this.onChanged}) : super(key: key);

  @override
  State<StatusDropdown> createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  String? selectedValue;

  final List<DropdownItem> items = [
    DropdownItem('Todos', null),
    DropdownItem('Validados', Colors.green),
    DropdownItem('Rejeitados', Colors.red),
    DropdownItem('Pendentes', Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey,width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: _buildDropdownItem(items[0]),
          isExpanded: true,
          items: items.map((DropdownItem item) {
            return DropdownMenuItem<String>(
              value: item.text,
              child: _buildDropdownItem(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue ?? '');
            }
          },
        ),
      ),
    );
  }

  Widget _buildDropdownItem(DropdownItem item) {
    return Row(
      children: [
        if (item.color != null)
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          )
        else
          const SizedBox(width: 20), // Space for alignment when no circle
        Text(
          item.text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class DropdownItem {
  final String text;
  final Color? color;

  DropdownItem(this.text, this.color);
}