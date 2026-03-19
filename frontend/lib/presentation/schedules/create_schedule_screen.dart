import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_day.dart';
import 'package:frontend/presentation/duty/duty_types_provider.dart';
import 'package:frontend/presentation/schedules/schedules_provider.dart';
import 'package:frontend/presentation/schedules/duty_days_provider.dart';

class CreateScheduleScreen extends ConsumerStatefulWidget {
  final int groupId;
  const CreateScheduleScreen({super.key, required this.groupId});

  @override
  ConsumerState<CreateScheduleScreen> createState() =>
      _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends ConsumerState<CreateScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedDutyTypeId;
  int _studentsPerDay = 1;
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  // Дни недели
  bool _monday = false;
  bool _tuesday = false;
  bool _wednesday = false;
  bool _thursday = false;
  bool _friday = false;
  bool _saturday = false;
  bool _sunday = false;

  @override
  Widget build(BuildContext context) {
    final dutyTypes = ref.watch(dutyTypesProvider); // просто список, не Future

    return Scaffold(
      appBar: AppBar(title: const Text('Создать расписание')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<int>(
              value: _selectedDutyTypeId,
              decoration: const InputDecoration(labelText: 'Тип дежурства'),
              items: dutyTypes.map((type) {
                return DropdownMenuItem(
                  value: type.id,
                  child: Text('${type.name} (${type.defaultScore} очков)'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedDutyTypeId = val),
              validator: (val) => val == null ? 'Выберите тип' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Студентов в день:'),
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: _studentsPerDay.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    onChanged: (val) =>
                        setState(() => _studentsPerDay = val.round()),
                  ),
                ),
                const SizedBox(width: 8),
                Text('$_studentsPerDay'),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Дата начала'),
              subtitle: Text(_startDate.toLocal().toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) setState(() => _startDate = date);
              },
            ),
            CheckboxListTile(
              title: const Text('Установить дату окончания'),
              value: _endDate != null,
              onChanged: (val) {
                setState(() {
                  _endDate = val == true
                      ? _startDate.add(const Duration(days: 7))
                      : null;
                });
              },
            ),
            if (_endDate != null)
              ListTile(
                title: const Text('Дата окончания'),
                subtitle: Text(_endDate!.toLocal().toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _endDate!,
                    firstDate: _startDate,
                    lastDate: _startDate.add(const Duration(days: 365)),
                  );
                  if (date != null) setState(() => _endDate = date);
                },
              ),
            const SizedBox(height: 16),
            const Text(
              'Дни дежурств:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._buildWeekDays(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Создать расписание'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWeekDays() {
    final days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    final values = [
      _monday,
      _tuesday,
      _wednesday,
      _thursday,
      _friday,
      _saturday,
      _sunday,
    ];
    final setters = [
      (v) => setState(() => _monday = v),
      (v) => setState(() => _tuesday = v),
      (v) => setState(() => _wednesday = v),
      (v) => setState(() => _thursday = v),
      (v) => setState(() => _friday = v),
      (v) => setState(() => _saturday = v),
      (v) => setState(() => _sunday = v),
    ];
    return List.generate(
      7,
      (i) => CheckboxListTile(
        title: Text(days[i]),
        value: values[i],
        onChanged: setters[i],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDutyTypeId == null) return;

    final days = DutyDay(
      scheduleId: 0, // будет заменено при создании
      isMonday: _monday,
      isTuesday: _tuesday,
      isWednesday: _wednesday,
      isThursday: _thursday,
      isFriday: _friday,
      isSaturday: _saturday,
      isSunday: _sunday,
    );

    await ref
        .read(groupSchedulesProvider(widget.groupId).notifier)
        .createSchedule(
          dutyTypeId: _selectedDutyTypeId!,
          studentsPerDay: _studentsPerDay,
          startDate: _startDate,
          endDate: _endDate,
          days: days,
        );

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Расписание создано')));
      Navigator.pop(context);
    }
  }
}
