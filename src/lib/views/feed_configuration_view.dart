import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:mediadrip/views/models/feed_config_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';
import 'package:mediadrip/views/providers/view_model_provider_value.dart';

class FeedConfigurationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FeedConfigViewModel>(
      model: FeedConfigViewModel(context:  context),
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
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        FlatButton(
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
      }
    );
  }

  Widget _dialog(BuildContext context, FeedConfigViewModel feedModel) {
    return ViewModelProviderValue<FeedConfigViewModel>(
      model: feedModel,
      builder: (model) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: model.nameInputController,
                    decoration: InputDecoration(
                      hintText: 'Enter a name...',
                      prefixIcon: Icon(Icons.person)
                    ),
                  ),
                  TextField(
                    controller: model.addressInputController,
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
                          FlatButton(
                            child: Text('Save'),
                            onPressed: () async {
                              Navigator.of(context).pop();

                              if(!await model.saveNewFeed()) {
                                showDialog(context: context, builder: (_) => _errorDialog(context, 'Address not understood.'));
                              }
                            }
                          ),
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
          )
        );
      }
    );
  }

  Widget _errorDialog(BuildContext context, String body) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(body),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}