import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';

class SectorModel {
  final String id;
  final String name;
  final int internsInSector;

  SectorModel({
    required this.id,
    required this.name,
    required this.internsInSector,
  });

  factory SectorModel.fromJson(Map<String, dynamic> json) {
    return SectorModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      internsInSector: json['internsInSector']?.toInt() ?? 0,
    );
  }
}

class SectorsDataTable extends StatefulWidget {
  final List<SectorModel> sectors;
  final Function(String sectorId)? onEdit;
  final Function(String sectorId)? onDelete;
  final bool isLoading;
  final String? errorMessage;

  const SectorsDataTable({
    Key? key,
    required this.sectors,
    this.onEdit,
    this.onDelete,
    this.isLoading = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  State<SectorsDataTable> createState() => _SectorsDataTableState();
}

class _SectorsDataTableState extends State<SectorsDataTable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List<SectorModel> _sortedSectors = [];

  @override
  void initState() {
    super.initState();
    _updateSortedSectors();
  }

  @override
  void didUpdateWidget(SectorsDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sectors != widget.sectors) {
      _updateSortedSectors();
    }
  }

  void _updateSortedSectors() {
    _sortedSectors = List.from(widget.sectors);
    _sortData();
  }

  void _sortData() {
    _sortedSectors.sort((a, b) {
      int result = 0;
      switch (_sortColumnIndex) {
        case 0: // ID
          result = a.id.compareTo(b.id);
          break;
        case 1: // Nome
          result = a.name.compareTo(b.name);
          break;
        case 2: // Estagiarios
          result = a.internsInSector.compareTo(b.internsInSector);
          break;
      }
      return _sortAscending ? result : -result;
    });
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _sortData();
    });
  }

  Widget _buildLiveIndicator(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PulsingCircle(),
        const SizedBox(width: 8),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showSectorDialog(SectorModel sector) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.business,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Informações do Setor',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sector Info
                _buildInfoRow('ID:', sector.id),
                const SizedBox(height: 16),
                _buildInfoRow('Nome:', sector.name),
                const SizedBox(height: 16),
                _buildLiveInfoRow('Estagiários:', sector.internsInSector),

                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onEdit?.call(sector.id);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showDeleteConfirmation(sector);
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildLiveInfoRow(String label, int count) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 12),
        _PulsingCircle(),
        const SizedBox(width: 8),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          count == 1 ? 'estagiário' : 'estagiários',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(SectorModel sector) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text(
            'Tem certeza que deseja excluir o setor "${sector.name}"?\n\n'
                'Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onDelete?.call(sector.id);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar dados',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                widget.errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_sortedSectors.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'Nenhum setor encontrado',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Não há setores cadastrados no momento.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: windowDesktopAppWidth(context) * 0.8,
      height: windowDesktopAppHeight(context) * 0.7,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Custom table header
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(100),
                  1: FlexColumnWidth(3),
                  2: FixedColumnWidth(120),
                },
                children: [
                  TableRow(
                    children: [
                      _buildHeaderCell('ID', 0),
                      _buildHeaderCell('Nome', 1),
                      _buildHeaderCell('Estagiários', 2),
                    ],
                  ),
                ],
              ),
            ),
      
            // Custom table body
            Expanded(
              child: ListView.builder(
                itemCount: _sortedSectors.length,
                itemBuilder: (context, index) {
                  final sector = _sortedSectors[index];
                  return InkWell(
                    onTap: () => _showSectorDialog(sector),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(100),
                          1: FlexColumnWidth(3),
                          2: FixedColumnWidth(120),
                        },
                        children: [
                          TableRow(
                            children: [
                              _buildDataCell(
                                Text(
                                  sector.id,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              _buildDataCell(
                                Text(
                                  sector.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              _buildDataCell(_buildLiveIndicator(sector.internsInSector)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, int columnIndex) {
    return InkWell(
      onTap: () => _onSort(columnIndex, !_sortAscending),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_sortColumnIndex == columnIndex) ...[
              const SizedBox(width: 4),
              Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: child,
    );
  }
}

// Pulsing red circle widget for live indicator
class _PulsingCircle extends StatefulWidget {
  @override
  State<_PulsingCircle> createState() => _PulsingCircleState();
}

class _PulsingCircleState extends State<_PulsingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Pulsing circle that grows and fades
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(_opacityAnimation.value),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Static center dot
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      },
    );
  }
}
