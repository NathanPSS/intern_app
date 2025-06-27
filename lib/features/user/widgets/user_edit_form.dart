import 'package:flutter/material.dart';

enum UserType { administrador, residente, preceptor }

class EditUserFormWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Function(Map<String, dynamic>)? onFormSubmit;
  final Function(String)? onPasswordChange;

  const EditUserFormWidget({
    Key? key,
    required this.userData,
    this.onFormSubmit,
    this.onPasswordChange,
  }) : super(key: key);

  @override
  State<EditUserFormWidget> createState() => _EditUserFormWidgetState();
}

class _EditUserFormWidgetState extends State<EditUserFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  UserType? _selectedUserType;
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;

  // Store original data for comparison
  late Map<String, dynamic> _originalData;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    _originalData = Map<String, dynamic>.from(widget.userData);

    _matriculaController.text = widget.userData['matricula'] ?? '';
    _nomeController.text = widget.userData['nomeCompleto'] ?? '';
    _emailController.text = widget.userData['email'] ?? '';

    final userTypeString = widget.userData['tipoUsuario'];
    if (userTypeString != null) {
      _selectedUserType = UserType.values.firstWhere(
            (type) => type.name == userTypeString,
        orElse: () => UserType.administrador,
      );
    }

    // Add listeners to detect changes
    _matriculaController.addListener(_detectChanges);
    _nomeController.addListener(_detectChanges);
    _emailController.addListener(_detectChanges);
  }

  void _detectChanges() {
    final currentData = _getCurrentFormData();
    final hasChanges = _originalData['matricula'] != currentData['matricula'] ||
        _originalData['nomeCompleto'] != currentData['nomeCompleto'] ||
        _originalData['email'] != currentData['email'] ||
        _originalData['tipoUsuario'] != currentData['tipoUsuario'];

    if (hasChanges != _hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = hasChanges;
      });
    }
  }

  Map<String, dynamic> _getCurrentFormData() {
    return {
      'matricula': _matriculaController.text.trim(),
      'nomeCompleto': _nomeController.text.trim(),
      'email': _emailController.text.trim(),
      'tipoUsuario': _selectedUserType?.name,
    };
  }

  @override
  void dispose() {
    _matriculaController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  void _showPasswordChangeDialog() {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool obscurePassword = true;
    bool obscureConfirm = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.lock_reset, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  const Text('Alterar Senha'),
                ],
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Digite a nova senha para o usuário ${_nomeController.text}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Nova Senha',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        helperMaxLines: 2,
                      ),
                      obscureText: obscurePassword,
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Nova Senha',
                        hintText: 'Digite a senha novamente',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureConfirm ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              obscureConfirm = !obscureConfirm;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: obscureConfirm,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;

                    // Validate password
                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Digite a nova senha'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (password.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senha deve ter pelo menos 8 caracteres'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!RegExp(r'[A-Z]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senha deve conter pelo menos uma letra maiúscula'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!RegExp(r'[a-z]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senha deve conter pelo menos uma letra minúscula'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!RegExp(r'[0-9]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senha deve conter pelo menos um número'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senha deve conter pelo menos um símbolo'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senhas não coincidem'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Password is valid, call the callback
                    if (widget.onPasswordChange != null) {
                      widget.onPasswordChange!(password);
                    }

                    Navigator.of(dialogContext).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Senha alterada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Alterar Senha'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione o tipo de usuário'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_hasUnsavedChanges) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma alteração foi feita'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));

    final formData = _getCurrentFormData();
    formData['id'] = widget.userData['id']; // Include user ID for update

    setState(() {
      _isLoading = false;
      _hasUnsavedChanges = false;
    });

    // Update original data
    _originalData = Map<String, dynamic>.from(formData);

    if (widget.onFormSubmit != null) {
      widget.onFormSubmit!(formData);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dados atualizados com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _discardChanges() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Descartar Alterações'),
          content: const Text('Tem certeza que deseja descartar todas as alterações feitas?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Descartar'),
            ),
          ],
        );
      },
    );
  }

  void _resetForm() {
    _matriculaController.text = _originalData['matricula'] ?? '';
    _nomeController.text = _originalData['nomeCompleto'] ?? '';
    _emailController.text = _originalData['email'] ?? '';

    final userTypeString = _originalData['tipoUsuario'];
    if (userTypeString != null) {
      _selectedUserType = UserType.values.firstWhere(
            (type) => type.name == userTypeString,
        orElse: () => UserType.administrador,
      );
    }

    setState(() {
      _hasUnsavedChanges = false;
    });
  }

  String _getUserTypeLabel(UserType type) {
    switch (type) {
      case UserType.administrador:
        return 'Administrador';
      case UserType.residente:
        return 'Residente';
      case UserType.preceptor:
        return 'Preceptor';
    }
  }

  Widget _getUserTypeImage(UserType type) {
    // For now using placeholder icons, replace with Image.asset() for your PNGs
    switch (type) {
      case UserType.administrador:
        return const Icon(
          Icons.admin_panel_settings,
          size: 48,
          color: Colors.blueGrey,
        );
      case UserType.residente:
        return const Icon(
          Icons.school,
          size: 48,
          color: Colors.green,
        );
      case UserType.preceptor:
        return const Icon(
          Icons.person_2,
          size: 48,
          color: Colors.orange,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.edit, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Editar Usuário',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                  ),
                  if (_hasUnsavedChanges)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Alterações pendentes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Atualize os dados do usuário conforme necessário',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Main Content Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Form fields
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Matricula Field
                        TextFormField(
                          controller: _matriculaController,
                          decoration: const InputDecoration(
                            labelText: 'Matrícula',
                            hintText: 'Digite a matrícula',
                            prefixIcon: Icon(Icons.badge),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => _validateRequired(value, 'Matrícula'),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),

                        // Nome Completo Field
                        TextFormField(
                          controller: _nomeController,
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
                            hintText: 'Digite o nome completo',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => _validateRequired(value, 'Nome Completo'),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 20),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Digite o email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),

                        // Password Change Button
                        OutlinedButton.icon(
                          onPressed: _showPasswordChangeDialog,
                          icon: const Icon(Icons.lock_reset),
                          label: const Text('Alterar Senha'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.orange[400]!),
                            foregroundColor: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // Right side - User Type and Image
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                //        const SizedBox(height: 24),

                        // User Type Selection
                        Text(
                          'Tipo de Usuário',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[700],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: UserType.values.map((type) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedUserType = type;
                                    });
                                    _detectChanges();
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _selectedUserType == type
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[300]!,
                                        width: _selectedUserType == type ? 2 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: _selectedUserType == type
                                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        Radio<UserType>(
                                          value: type,
                                          groupValue: _selectedUserType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedUserType = value;
                                            });
                                            _detectChanges();
                                          },
                                          materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _getUserTypeLabel(type),
                                          style: TextStyle(
                                            fontWeight: _selectedUserType == type
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            color: _selectedUserType == type
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _hasUnsavedChanges ? _discardChanges : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: _hasUnsavedChanges
                            ? BorderSide(color: Colors.red[400]!)
                            : null,
                        foregroundColor: _hasUnsavedChanges ? Colors.red[700] : null,
                      ),
                      child: Text(_hasUnsavedChanges ? 'Descartar' : 'Sem alterações'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: (_isLoading || !_hasUnsavedChanges) ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                          : const Text('Salvar Alterações'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}