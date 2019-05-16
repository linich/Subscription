#  Subscriptions

The program consists of three main classes: CountryListViewController, SubscriptionSelectorViewController and SubscriptionFlow.

*CountryListViewController* displays a list of available countries and notifies through the callback function which country has been selected.

*SubscriptionSelectorViewController* allows you to select and activate a subscription.

*SubscriptionFlow* is responsible for creating, customizing and displaying ViewControllers. It determines in what sequence and in response to which actions from the user will switch between ViewControllers.

ViewControllers use viewModel to get data specific to these controllers. In the current implementation, the viewModel contains data in itself. In a real system, the viewModel will use a services to get data.

*SubscriptionSelectorViewController* consists of two *UICollectionViews*. One displays general subscription information. The second allows user to select the subscription period.
