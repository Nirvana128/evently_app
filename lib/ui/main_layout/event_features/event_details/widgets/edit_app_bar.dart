import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/utils/toast_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/app_bar_title.dart';
import 'package:evently/ui/main_layout/event_features/event_details/widgets/appbar_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditAppBar({super.key, this.onEventUpdated});
  final Function(Event)? onEventUpdated;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return AppBarTitle(
      title: AppLocalizations.of(context)!.eventDetails,
      actions: [
        AppbarActionButtons(
          onTap: () async{
            var returnedEventModel = await Navigator.pushNamed(
              context,
              AppRoutes.addEventView,
              arguments: event,
            );
            if (returnedEventModel != null && returnedEventModel is Event) {
              onEventUpdated?.call(returnedEventModel);
            }
          },
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        5.horizontalSizedBox,
        AppbarActionButtons(
          onTap: () async {
            await deleteEvent(context, userProvider, event);
          },
          icon: Icon(
            Icons.delete_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        16.horizontalSizedBox,
      ],
    );
  }

  Future<dynamic> deleteEvent(
    BuildContext context,
    UserProvider userProvider,
    Event event,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteEvent),
        content: Text(AppLocalizations.of(context)!.areYouSureYouWantToDeleteThisEvent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<EventsProvider>().deleteEvent(
                userProvider.currentUser!.uid,
                event.id,
              );

              Navigator.pop(context);
              Navigator.pop(context);

              ToastUtils.showSuccessToast(
                AppLocalizations.of(context)!.eventDeletedSuccessfully,
                context,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
