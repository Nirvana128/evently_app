import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/extensions/image_changer_theme_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/utils/focus_util.dart';
import 'package:evently/core/utils/toast_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/event_type.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/firebase_service.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:evently/ui/auth_flow/widgets/custom_text_form_field.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/app_bar_title.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/date_and_time_widget.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/event_image.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/event_types_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAndUpdateEvent extends StatefulWidget {
  const AddAndUpdateEvent({super.key});

  @override
  State<AddAndUpdateEvent> createState() => _AddAndUpdateEventState();
}

class _AddAndUpdateEventState extends State<AddAndUpdateEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  String? formatedDate;
  TimeOfDay? selectedTime;
  String? formatedTime;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final argEvent = ModalRoute.of(context)?.settings.arguments as Event?;

    if (!isInitialized && argEvent != null) {
      titleController.text = argEvent.title;
      descriptionController.text = argEvent.description;
      selectedDate = argEvent.dateTime;
      selectedTime = TimeOfDay.fromDateTime(argEvent.dateTime);
      formatedDate = DateFormat('yMd').format(argEvent.dateTime);
      formatedTime = TimeOfDay.fromDateTime(argEvent.dateTime).format(context);
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments as Event?;
    final isEdit = event != null;
    final eventTabs = EventType.getEventTypes(context).sublist(1);
    final userProvider = context.read<UserProvider>();
    String imgPath = eventTabs[selectedIndex].imagePath.changeImageTheme(
      context,
    );

    return GestureDetector(
      onTap: () => FocusUtil.hideKeyboard(context),
      child: Scaffold(
        appBar: AppBarTitle(
          title: isEdit
              ? AppLocalizations.of(context)!.editEvent
              : AppLocalizations.of(context)!.addEvent,
        ),
        body: Padding(
          padding: AppPadding.view,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  // Event image
                  EventImage(imagePath: imgPath),

                  // Event types list view
                  16.verticalSizedBox,
                  EventTypesListView(
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                        imgPath = eventTabs[selectedIndex].imagePath
                            .changeImageTheme(context);
                      });
                    },
                  ),

                  // Event title text field
                  16.verticalSizedBox,
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  8.verticalSizedBox,
                  CustomTextFormField(
                    controller: titleController,
                    validator: (_) => null,
                    labelText: AppLocalizations.of(context)!.eventTitle,
                  ),

                  // Event description text field
                  16.verticalSizedBox,
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  8.verticalSizedBox,
                  CustomTextFormField(
                    controller: descriptionController,
                    validator: (_) => null,
                    labelText: AppLocalizations.of(context)!.eventDescription,
                    maxLines: 5,
                  ),

                  // event date and time picker
                  10.verticalSizedBox,
                  DateAndTimeWidget(
                    onTap: chooseDate,
                    icon: Icons.calendar_month_outlined,
                    label: AppLocalizations.of(context)!.eventDate,
                    buttonText: selectedDate == null
                        ? AppLocalizations.of(context)!.chooseDate
                        : formatedDate ?? '',
                  ),
                  DateAndTimeWidget(
                    onTap: chooseTime,
                    icon: Icons.access_time_outlined,
                    label: AppLocalizations.of(context)!.eventTime,
                    buttonText: selectedTime == null
                        ? AppLocalizations.of(context)!.chooseTime
                        : formatedTime ?? '',
                  ),

                  // Add event button
                  30.verticalSizedBox,
                  CustomButton(
                    onPressed: () {
                      if (selectedDate == null || selectedTime == null) {
                        ToastUtils.showErrorToast(
                          'Please select date and time',
                          context,
                        );
                        return;
                      }

                      final finalDateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      final argEvent =
                          ModalRoute.of(context)?.settings.arguments as Event?;
                      Event event = Event(
                        id: argEvent?.id ?? '',
                        eventType: eventTabs[selectedIndex].name,
                        dateTime: finalDateTime,
                        title: titleController.text,
                        description: descriptionController.text,
                        imagePath: eventTabs[selectedIndex].imagePath,
                      );

                      if (isEdit) {
                        FirebaseService.updateEventInFirestore(
                              event,
                              userProvider.currentUser!.uid,
                            )
                            .then((_) async {
                              ToastUtils.showSuccessToast(
                                AppLocalizations.of(
                                  context,
                                )!.eventUpdatedSuccessfully,
                                context,
                              );

                              await context.read<EventsProvider>().getAllEvents(
                                userProvider.currentUser!.uid,
                              );

                              Navigator.pop(context, event);
                            })
                            .catchError((error) {
                              ToastUtils.showErrorToast(
                                AppLocalizations.of(
                                  context,
                                )!.failedToUpdateEvent,
                                context,
                              );
                            });
                      } else {
                        FirebaseService.addEventToFirestore(
                              event,
                              userProvider.currentUser!.uid,
                            )
                            .then((_) async {
                              ToastUtils.showSuccessToast(
                                AppLocalizations.of(
                                  context,
                                )!.eventAddedSuccessfully,
                                context,
                              );

                              await context.read<EventsProvider>().getAllEvents(
                                userProvider.currentUser!.uid,
                              );

                              Navigator.pop(context);
                            })
                            .catchError((error) {
                              ToastUtils.showErrorToast(
                                AppLocalizations.of(context)!.failedToAddEvent,
                                context,
                              );
                            });
                      }
                    },
                    label: isEdit
                        ? AppLocalizations.of(context)!.updateEvent
                        : AppLocalizations.of(context)!.addEvent,
                  ),
                  10.verticalSizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> chooseDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 730)),
      builder: (context, child) {
        return Theme(
          data:
              Provider.of<ThemeProvider>(context).currentMode == ThemeMode.dark
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        formatedDate = DateFormat('yMd').format(selectedDate!);
      });
    }
  }

  Future<void> chooseTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data:
              Provider.of<ThemeProvider>(context).currentMode == ThemeMode.dark
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        formatedTime = selectedTime!.format(context);
      });
    }
  }
}
