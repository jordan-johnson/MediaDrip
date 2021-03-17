import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/providers/widget_provider_value.dart';
import 'package:mediadrip/ui/widgets/drip_dialog.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _FeedConfigurationViewModel extends WidgetModel {
  final FeedService _feedService = locator<FeedService>();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();

  Map<String, String> feeds = Map<String, String>();

  _FeedConfigurationViewModel({@required BuildContext context}) : super(context: context);

  @override
  Future<void> initialize() async {
    await updateFeeds();
  }

  Future<void> updateFeeds() async {
    this.feeds = await _feedService.getFeedsFromConfig();

    notifyListeners();
  }

  void writeNew() {
    nameTextController.clear();
    addressTextController.clear();

    notifyListeners();
  }

  Future<void> deleteFeed(String key) async {
    if(feeds.containsKey(key)) {
      feeds.remove(key);

      await _saveChanges();
    }
  }

  Future<bool> saveNewFeed() async {
    var interpreted = await _feedService.getInterpretedAddress(addressTextController.text);

    if(interpreted != null) {
      feeds[nameTextController.text] = interpreted;

      await _saveChanges();

      return true;
    }

    return false;
  }

  Future<void> _saveChanges() async {
    await _feedService.writeFeedsToConfig(feeds);

    notifyListeners();
  }
}

class FeedConfigurationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_FeedConfigurationViewModel>(
      model: _FeedConfigurationViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'Configure Feed',
          route: Routes.feedConfiguration,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              model.writeNew();
              
              showDialog(
                context: context,
                builder: (_) => _dialog(context, model)
              );
            }
          ),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => Divider(),
            itemCount: model.feeds.length,
            itemBuilder: (_, index) {
              var feedEntry = model.feeds.entries.elementAt(index);

              return ListTile(
                title: Text(feedEntry.key),
                subtitle: Text(feedEntry.value),
                trailing: GestureDetector(
                  onTap: () {
                    var alert = AlertDialog(
                      title: Text('Confirm deletion'),
                      content: Text('Are you sure you wish to delete ${feedEntry.key}?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            model.deleteFeed(feedEntry.key);

                            Navigator.of(context).pop();
                          }
                        )
                      ],
                    );

                    showDialog(context: context, builder: (_) => alert);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            },
          )
        );
      },
    );
  }

  Widget _dialog(BuildContext context, _FeedConfigurationViewModel viewModel) {
    return WidgetProviderValue<_FeedConfigurationViewModel>(
      model: viewModel,
      builder: (model) {
        return DripDialog(
          width: 400,
          height: 200,
          children: [
            TextField(
              controller: model.nameTextController,
              decoration: InputDecoration(
                hintText: 'Enter a name...',
                prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              controller: model.addressTextController,
              decoration: InputDecoration(
                hintText: 'Enter an address...',
                prefixIcon: Icon(Icons.http)
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: Text('Save'),
                      onPressed: () async {
                        Navigator.of(context).pop();

                        if(!await model.saveNewFeed()) {
                          showDialog(
                            context: context,
                            builder: (_) => _errorDialog(context, 'Address not understood.')
                          );
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _errorDialog(BuildContext context, String body) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(body),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}