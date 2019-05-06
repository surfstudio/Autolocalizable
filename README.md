# Autolocalizable

[![CI Status](https://img.shields.io/travis/git/Autolocalizable.svg?style=flat)](https://travis-ci.org/git/Autolocalizable)
[![Version](https://img.shields.io/cocoapods/v/Autolocalizable.svg?style=flat)](https://cocoapods.org/pods/Autolocalizable)
[![License](https://img.shields.io/cocoapods/l/Autolocalizable.svg?style=flat)](https://cocoapods.org/pods/Autolocalizable)
[![Platform](https://img.shields.io/cocoapods/p/Autolocalizable.svg?style=flat)](https://cocoapods.org/pods/Autolocalizable)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

[Anatoly Cherkasov](https://github.com/virpik), cherkasov@surfstudio.ru

## Collaborators

[Alexander Filimonov](https://github.com/alexfilimon)

## License

Autolocalizable is available under the MIT license. See the LICENSE file for more info.

## Что бы избежать лишних импортов

В `Bridging-Header.h` проекта стоит тобавить строчку: 

```objective-c

#import "Autolocalizable/Autolocalizable-Swift.h"

```

## Базовые возможности

- Держит значение активного языка 
- Локализация одного текстового поля (UILabеl например)
- Отслеживание смены языка таргетно 
- Поддержка NSAttributtedString 
- Локализация с учетом склонений и различных трансформаций (_uppercased_, _capitalizingFirstLetter_)
- Горячее подключение таблиц для локализации (Например текст может приходить с сервера) (см протокол [LocalizableValueService](LocalizableValueService))

## Примеры использования

#### Базовое использование:

К классам _UILabel_, _UIButton_, _UITabbarItem_, _UIViewController_(заголовок) подключен протокол **AutoLocalizableField** - он позволяет зарегистрировать объект в системе авто локализации, при заполнении поля **localized**. 

```swift

labelDecription.localized = LocalizableStringItem("description")
sendButton.localized = LocalizableStringItem("send")
viewController.localizedTitle = LocalizableStringItem("viewControllerTitle")

```

при смене языка, текст автоматически заменится.

#### Отслеживание смены языка:

Пример отслеживания смены языка: 

```swift
final class MyClass: AutolocalizableFollowing {

    init() {
	followAutolocalization()
    }

    // MARK: - AutolocalizableFollowing

    func languageWasChanged(locale: LocaleType) {
        /// ... code    
    }

}

```

## SwiftGen

Доступен шаблон для подключения автоматической генерации через SwiftGen.
Шаблон находится в корне репозитория (swiftgen-templates).
Узнать про установку кастомных шаблонов можно в репозитории проекта [SwiftGen](https://github.com/SwiftGen/SwiftGen#choosing-your-template)

Если генерация успешно интегрирована, доступен подобный синтаксис: 
`titleLabel.localized = L10n.ViewController.title`

## Описание helper-ов

#### LocalizableValueService

Протокол, для чтения .strings файлов запрашиваемого языка

**Методы**

```swift
func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: LocaleType) -> String

```

Метод для получения переведенной строки на указанный язык, по ключу

_table_ - Таблица _.strings_ (По умолчанию Localizable.strings)

_key_ - Ключ строки, для которой требуется перевод (Например "Login.title")

_args_ - Список аргументов для форматирования (Необходимо указывать если в перевод подставляются данные через %@)

_locale_ - Требуемый язык

Базовая реализация протокола доступна в классе `BaseLocalizableValueService`

#### LocalizableStringItem 

Моделька, оборачивает параметры строки, необходимые для локализации. Подключен к _SwiftGen_

**Свойства**

```swift
private(set) var value: String

```

Возвращает локализированную строку

**Конструкторы**

```swift
init(_ key: String = "", _ args: CVarArg...)

```

_key_ - Ключ локализации

_args_ - Список аргументов для форматирования

```swift
init(_ table: String, _ key: String, _ args: CVarArg...)

```

_table_ - Название .strings таблицы

_key_ - Ключ локализации

_args_ - Список аргументов для форматирования

**Методы**

```swift
func set(localizableService: LocalizableValueService) -> LocalizableStringItem

```

Позволяет установить таблицу для получения локализаций. Возвращает _LocalizableStringItem_ сконфигурированный для получения строки из указаного сервиса. 

```swift
func add(transform: @escaping ((String) -> String)) -> LocalizableStringItem

```

Добавляет transform к локализуемой строке. Возвращает _LocalizableStringItem_ с добавленным в очередь трансформом. 

Правила трансформации: На вход блока приходит локализованная строка, **обработанная ранее добавленными _transform_-блоками**, в блоке необходимо вернуть измененную строку.

```swift
func addDeclension(_ value: Int?) -> LocalizableStringItem

```

Подключает склонения к локализованной строке

```swift
func uppercased() -> LocalizableStringItem

```

Переводит всю локализируемую строку в верхний регистр

```swift
func lowercased() -> LocalizableStringItem

```

Переводит всю локализируемую строку в нижний регистр

```swift
func capitalizingFirstLetter() -> LocalizableStringItem

```

Переводит первый символ локализуемой строки в верхний регистр

```swift
func attributedItem(with attributed: [NSAttributedString.Key: Any]) -> LocalizableAttributedStringItem

```

Позволяет получить  _AttributedString_ из локализованной строки  

#### LocalizableAttributedStringItem

Аналог _LocalizableStringItem_ для работы с  _AttributedString_

**Свойства**

```swift
private(set) var value: NSAttributedString

```

Локализованная строка с примененными атрибутами

```swift
private(set) var item: LocalizableStringItem

```

Исходный элемент локализации

**Конструкторы**

```swift
init(item: LocalizableStringItem, attributed: [NSAttributedString.Key: Any])

```

_item_ - исходный _LocalizableStringItem_

_attributed_ - Применяемые атрибуты

## Описание протоколов

#### protocol AutoLocalizableField

**Свойства:**

```swift
var localized: LocalizableStringItem? { get set }

```

Не требует реализации. 
При заполнении, зарегистрирует текущий объект в системе авто локализации с указанным _LocalizableStringItem_

Если передать _nil_ - удалит из системы локализации.

**Методы:**

```swift
func languageWasChanged(locale: LocaleType, localizableString: LocalizableStringItem?)

```

Метод вызовется при смене локализации

_locale_ - новый язык

_localizableString_ -  _LocalizableStringItem_, указанный при регистрации. 

#### protocol AutoLocalizableAttributedField

Аналог _AutoLocalizableField_, но для _AttributedString_


#### protocol AutolocalizableFollowing

Позволяет подписаться на обновление локализации

В классе, к которому подключается протокол, необходимо реализовать метод  

```swift
func languageWasChanged(locale: LocaleType)`

```

Для отслеживания смены языка вызывать `followAutolocalization()`, для отмены `unfollowAutolocalization` 


