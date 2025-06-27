import 'package:flutter/material.dart';
import 'package:intern_app/features/registries/domain/records/registry_data_table_record.dart';

// class TableRecord {
//   final String id;
//   final String residente;
//   final String preceptor;
//   final DateTime data;
//   final String setor;
//   final Widget status;
//
//   TableRecord({
//     required this.id,
//     required this.residente,
//     required this.preceptor,
//     required this.data,
//     required this.setor,
//     required this.status,
//   });
// }

class RegistryDataTable extends StatefulWidget {
  final List<RegistryDataTableRecord> records;
  final Function(RegistryDataTableRecord)? onRowTap;
  final Function(RegistryDataTableRecord)? onRowDoubleTap;

  const RegistryDataTable({
    super.key,
    required this.records,
    this.onRowTap,
    this.onRowDoubleTap,
  });

  @override
  State<RegistryDataTable> createState() => _DesktopDataTableState();
}

class _DesktopDataTableState extends State<RegistryDataTable> {
  final TextEditingController _residenteController = TextEditingController();
  final TextEditingController _preceptorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<RegistryDataTableRecord> _filteredRecords = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredRecords = List.from(widget.records);
    _residenteController.addListener(_filterRecords);
    _preceptorController.addListener(_filterRecords);
  }

  @override
  void dispose() {
    _residenteController.dispose();
    _preceptorController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _filterRecords() {
    setState(() {
      _filteredRecords = widget.records.where((record) {
        final residenteMatch = record.residente
            .toLowerCase()
            .contains(_residenteController.text.toLowerCase());
        final preceptorMatch = record.preceptor
            .toLowerCase()
            .contains(_preceptorController.text.toLowerCase());

        bool dateMatch = true;
        if (_selectedDate != null) {
          dateMatch = record.data.day == _selectedDate!.day &&
              record.data.month == _selectedDate!.month &&
              record.data.year == _selectedDate!.year;
        }

        return residenteMatch && preceptorMatch && dateMatch;
      }).toList();
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
      _filterRecords();
    }
  }

  void _clearDateFilter() {
    setState(() {
      _selectedDate = null;
      _dateController.clear();
    });
    _filterRecords();
  }

  void _showDetailsDialog(RegistryDataTableRecord record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detalhes do Registro',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailRow('ID:', record.id),
                _buildDetailRow('Residente:', record.residente),
                _buildDetailRow('Preceptor:', record.preceptor),
                _buildDetailRow('Data:',
                    "${record.data.day.toString().padLeft(2, '0')}/"
                        "${record.data.month.toString().padLeft(2, '0')}/"
                        "${record.data.year}"
                ),
                _buildDetailRow('Setor:', record.setor),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Status: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 50),
                    record.status,
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fechar'),
                    ),
                    // const SizedBox(width: 8),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     if (widget.onRowTap != null) {
                    //       widget.onRowTap!(record);
                    //     }
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue[600],
                    //     foregroundColor: Colors.white,
                    //   ),
                    //   child: const Text('Ação'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              children: [
                // Residente Search
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Residente',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _residenteController,
                        decoration: InputDecoration(
                          hintText: 'Buscar por residente...',
                          prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Preceptor Search
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preceptor',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _preceptorController,
                        decoration: InputDecoration(
                          hintText: 'Buscar por preceptor...',
                          prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Date Search
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: _selectDate,
                        decoration: InputDecoration(
                          hintText: 'Selecionar data...',
                          prefixIcon: Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                          suffixIcon: _selectedDate != null
                              ? IconButton(
                            icon: Icon(Icons.clear, size: 18, color: Colors.grey[600]),
                            onPressed: _clearDateFilter,
                          )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Results counter
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    '${_filteredRecords.length} resultado(s)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                  dataTextStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  columnSpacing: 20,
                  horizontalMargin: 16,
                  headingRowHeight: 52,
                  dataRowHeight: 56,
                  showCheckboxColumn: false,
                  columns: [
                    const DataColumn(
                      label: Text('ID'),
                    ),
                    DataColumn(
                      label: const Text('Residente'),
                    ),
                    DataColumn(
                      label: const Text('Preceptor'),
                    ),
                    DataColumn(
                      label: const Text('Data'),
                    ),
                    DataColumn(
                      label: const Text('Setor'),
                    ),
                    const DataColumn(
                      label: Text('Status'),
                    ),
                  ],
                  rows: _filteredRecords.asMap().entries.map((entry) {
                    final index = entry.key;
                    final record = entry.value;

                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.blue.withOpacity(0.08);
                          }
                          if (states.contains(MaterialState.selected)) {
                            return Colors.blue.withOpacity(0.12);
                          }
                          if (index % 2 == 0) {
                            return Colors.grey.withOpacity(0.03);
                          }
                          return Colors.transparent;
                        },
                      ),
                      onSelectChanged: (_) => _showDetailsDialog(record),
                      cells: [
                        DataCell(
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              record.id.length > 8
                                  ? '${record.id.substring(0, 8)}...'
                                  : record.id,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(record.residente)),
                        DataCell(Text(record.preceptor)),
                        DataCell(
                          Text(
                            "${record.data.day.toString().padLeft(2, '0')}/"
                                "${record.data.month.toString().padLeft(2, '0')}/"
                                "${record.data.year}",
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                        DataCell(Text(record.setor)),
                        DataCell(record.status),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage and status widgets
class StatusChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const StatusChip({
    super.key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}