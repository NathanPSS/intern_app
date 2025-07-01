import 'package:flutter/material.dart';
import 'package:intern_app/core/widgets/main_area.dart';
import 'package:intern_app/features/user/datasources/user_data_view.dart';
import 'package:intern_app/features/user/widgets/user_type_widget.dart';
import 'package:provider/provider.dart';

class UserDataTable extends StatefulWidget {
  final List<UserDataView> records;
  final Function(UserDataView)? onRowTap;
  final Function(UserDataView)? onRowDoubleTap;

  const UserDataTable({
    super.key,
    required this.records,
    this.onRowTap,
    this.onRowDoubleTap,
  });

  @override
  State<UserDataTable> createState() => _DesktopDataTableState();
}

class _DesktopDataTableState extends State<UserDataTable> {
  final TextEditingController _userNameController = TextEditingController();

  List<UserDataView> _filteredRecords = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredRecords = List.from(widget.records);
    _userNameController.addListener(_filterRecords);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void _filterRecords() {
    setState(() {
      _filteredRecords = widget.records.where((record) {
        final usernameMatch = record.userName.toLowerCase().contains(
          _userNameController.text.toLowerCase(),
        );

        return usernameMatch;
      }).toList();
    });
  }

  void _showDetailsDialog(UserDataView record) {
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
                      'Detalhes do Usuário',
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
                _buildDetailRow('Nome:', record.userName),
                _buildDetailRow('Matricula:', record.userMatricula),
                _buildDetailRow('Email:', record.userEmail),
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
                    UserTypeWidget(userType: record.userType),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop(); // Close the dialog
                            }
                            Provider.of<NavigationProvider>(
                              context,
                              listen: false,
                            ).navigateToScreen({
                              'screen': 'editUserForm',
                              'userData': record,
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: const Text(
                              "Editar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: const Text(
                              "Remover",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fechar'),
                    ),
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
              style: const TextStyle(fontSize: 14, color: Colors.black87),
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
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                // Residente Search
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: 'Buscar por usuário...',
                          prefixIcon: Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.grey[600],
                          ),
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
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
            child: SizedBox(
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
                    const DataColumn(label: Text('Matricula')),
                    DataColumn(label: const Text('Nome')),
                    DataColumn(label: const Text('Email')),
                    DataColumn(label: const Text('Tipo')),
                  ],
                  rows: _filteredRecords.asMap().entries.map((entry) {
                    final index = entry.key;
                    final record = entry.value;

                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>((
                        Set<MaterialState> states,
                      ) {
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
                      }),
                      onSelectChanged: (_) => _showDetailsDialog(record),
                      cells: [
                        DataCell(
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              record.userMatricula.length > 8
                                  ? '${record.userMatricula.substring(0, 8)}...'
                                  : record.userMatricula,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(record.userName)),
                        DataCell(Text(record.userEmail)),
                        DataCell(UserTypeWidget(userType: record.userType)),
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
  final Widget type;

  const StatusChip({super.key, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: type,
    );
  }
}
