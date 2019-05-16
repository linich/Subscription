#  Subscriptions

Программа состоит из трех главных классов: CountryListViewController, SubscriptionSelectorViewController и SubscriptionFlow.

*CountryListViewController* отображет список доступных стран и оповещает через функцию обратного вызова о том, какая страна была выбрана.

*SubscriptionSelectorViewController* позволяет выбрать и активизировать подписку.

*SubscriptionFlow* отвечает за создание, настройку и отображение  ViewController-ов. Он определяет в какой последовательности и в ответ на какие действие от пользователя будет происходить переключение между ViewController-ами.

ViewController-ы используют viewModel для получение данных специфичных для этих контроллеров. В текущей реализации viewModel содержат данные в самих себе. В реальнной системе viewModel-и будут обращаться к сервисам для получения данных.

*SubscriptionSelectorViewController* состоит из двух *UICollectionView*. Одна отображает общую информацию о подписке. Вторая позволяет выбрать период подписки.
