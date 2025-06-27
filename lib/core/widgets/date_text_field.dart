import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final bool enabled;

  const DateTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateDate(String value) {
    setState(() {
      _errorText = null;
    });

    if (value.isEmpty) return;

    // Check if the format is complete
    if (value.length < 10) {
      setState(() {
        _errorText = 'Data Incompleta';
      });
      return;
    }

    // Parse the date components
    final parts = value.split('/');
    if (parts.length != 3) {
      setState(() {
        _errorText = 'Formato de Data inválido';
      });
      return;
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      setState(() {
        _errorText = 'Formato de Data inválido';
      });
      return;
    }

    // Basic validation
    if (month < 1 || month > 12) {
      setState(() {
        _errorText = 'Mês deve ser 1 a 12';
      });
      return;
    }

    if (day < 1 || day > 31) {
      setState(() {
        _errorText = 'Dia deve ser entre 1 a 31';
      });
      return;
    }

    if (year < 2025 || year > 2100) {
      setState(() {
        _errorText = 'Ano entre 2025 a 2100';
      });
      return;
    }

    // Days in month validation
    final daysInMonth = _getDaysInMonth(month, year);
    if (day > daysInMonth) {
      setState(() {
        _errorText = 'Dia ou mês não permitido';
      });
      return;
    }
  }

  int _getDaysInMonth(int month, int year) {
    switch (month) {
      case 1: case 3: case 5: case 7: case 8: case 10: case 12:
      return 31;
      case 4: case 6: case 9: case 11:
      return 30;
      case 2:
        return _isLeapYear(year) ? 29 : 28;
      default:
        return 31;
    }
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DateInputFormatter(),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText ?? '__/__/____',
        errorText: _errorText,
        suffixIcon: const Icon(Icons.date_range),
      ),
      onChanged: (value) {
        _validateDate(value);
        widget.onChanged?.call(value);
      },
      onSubmitted: (value) {
        _validateDate(value);
        widget.onSubmitted?.call(value);
      },
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text.length > 8) {
      return oldValue;
    }

    String formatted = '';
    String correctedText = text;
    int cursorPosition = newValue.selection.end;

    // Auto-correct values that exceed constraints
    if (text.length >= 2) {
      final dayStr = text.substring(0, 2);
      final day = int.tryParse(dayStr);
      if (day != null && day > 31) {
        correctedText = '31${text.substring(2)}';
      }
    }

    if (text.length >= 4) {
      final monthStr = correctedText.substring(2, 4);
      final month = int.tryParse(monthStr);
      if (month != null && month > 12) {
        correctedText = '${correctedText.substring(0, 2)}12${correctedText.substring(4)}';
      }
    }

    // Additional day validation based on month
    if (correctedText.length >= 4) {
      final dayStr = correctedText.substring(0, 2);
      final monthStr = correctedText.substring(2, 4);
      final day = int.tryParse(dayStr);
      final month = int.tryParse(monthStr);

      if (day != null && month != null) {
        int maxDays = 31;
        if (month == 2) {
          maxDays = 29; // We'll assume leap year for now, more precise validation happens later
        } else if ([4, 6, 9, 11].contains(month)) {
          maxDays = 30;
        }

        if (day > maxDays) {
          correctedText = '${maxDays.toString().padLeft(2, '0')}${correctedText.substring(2)}';
        }
      }
    }

    for (int i = 0; i < correctedText.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
        if (i < cursorPosition) {
          cursorPosition++;
        }
      }
      formatted += correctedText[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}