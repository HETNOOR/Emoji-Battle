### Проект "Emoji Battle"

**Автор**: Максим Герасимов

Данный проект представляет собой реализацию классов для одной видеоигры "Emoji Battle", где игрок сражается с монстрами, используя эмодзи-существ.

### Описание игры

Игра "Emoji Battle" представляет собой сражение между игроком и монстрами. Каждое существо в игре (включая игрока и монстров) характеризуется следующими параметрами:

1. **Атака и Защита**: Это целые числа от 1 до 30, определяющие силу атаки и способность защиты существа.

2. **Здоровье**: Это натуральное число от 0 до N. Если здоровье существа становится равным 0, существо умирает. Игрок может исцелить себя до 4-х раз на 30% от максимального здоровья.

3. **Урон**: Это диапазон натуральных чисел M - N, например, 1-6.

Существа могут совершать удары друг по другу по следующему алгоритму:

- Рассчитываем Модификатор атаки, который равен разнице Атаки атакующего и Защиты защищающегося, плюс 1.

- Успех определяется броском N кубиков с цифрами от 1 до 6, где N - это Модификатор атаки. Всегда бросается хотя бы один кубик.

- Удар считается успешным, если хотя бы на одном из кубиков выпадает 5 или 6.

- Если удар успешен, то берется произвольное значение из параметра Урон атакующего и вычитается из Здоровья защищающегося.

### Особенности проекта

- Весь проект реализован в объектно-ориентированном стиле.

- Объекты обязательно реагируют на некорректные аргументы методов.

- Проект включает в себя классы сущностей "Игрок" и "Монстр", а также может содержать дополнительные классы по желанию разработчика.

Атака в игре "Emoji Battle" представляет собой ключевую механику, в результате которой существо (игрок или монстр) пытается нанести урон своему противнику. Давайте подробно опишем эту механику и предоставим соответствующий код.

### Механика атаки

1. **Рассчет модификатора атаки**: Сначала рассчитывается модификатор атаки, который зависит от атаки атакующего и защиты защищающегося. Модификатор атаки всегда равен как минимум 1, чтобы гарантировать, что даже слабая атака имеет шанс попадания. 

2. **Бросок кубиков**: Далее совершается бросок N кубиков, где N - это модификатор атаки. Этот бросок моделирует шанс попадания атаки. В игре предполагается, что используется стандартный кубик с 6 гранями.

3. **Проверка успешной атаки**: Удар считается успешным, если хотя бы на одном из кубиков выпадает 5 или 6. Если успешной атаки не произошло, атакующее существо промахивается.

4. **Нанесение урона**: Если атака успешна, то происходит нанесение урона противнику. Урон определяется случайным образом из заданного диапазона урона атакующего существа. Урон может быть улучшен или изменен в зависимости от других игровых факторов.

### Пример кода

Вот пример кода для метода атаки в классе `Creature`:

```swift
   func attack(target: Creature) {
        
            // Рассчитываем Модификатор атаки
            let attackModifier = max(attack - target.defense + 1, 1)
            
            // Бросок N кубиков
            let numberOfDice = attackModifier
            for _ in 1...numberOfDice {
                let diceRoll = Int.random(in: 1...6)
                diceCount = diceRoll
                if diceRoll >= 5 {
                    let damage = Int.random(in: damageRange)
                    target.takeDamage(damage+upgrate)
                    break
                }
            }
          
        }
    
    
    func takeDamage(_ damage: Int) {
        health -= damage
        damageNow = damage
        if health < 0 {
            health = 0
        }
    }
```

В этом коде мы сначала рассчитываем модификатор атаки, затем бросаем N кубиков и проверяем, выпали ли значения 5 или 6. Если выпало хотя бы одно такое значение, то атака считается успешной, и мы наносим урон цели, который определяется случайным образом из диапазона урона атакующего существа.

Атака - это основной способ воздействия на противника в игре "Emoji Battle", и ее результаты оказывают существенное влияние на исход битвы.


### Структура проекта

Проект содержит следующие файлы и директории:

- `ViewController.swift`: Основной файл с реализацией интерфейса игры и взаимодействием с пользователем.

- `Creature.swift`: Файл с классом `Creature`, который представляет собой базовый класс для существ в игре, включая игрока и монстров.

- `Game.swift`: Файл с классом `Game`, который управляет ходом игры, созданием новых монстров и проверкой окончания игры.

- `Player.swift`: Файл с классом `Player`, который представляет игрового персонажа (игрока) и содержит дополнительные методы для управления игрой.

- `ViewControllerStore.swift`: Файл с классом `ViewControllerStore`, который отвечает за отображение магазина в игре, покупку предметов и улучшения атаки игрока.

- Дополнительные файлы, необходимые для работы с интерфейсом (возможно, storyboard, xib-файлы, изображения и т. д.).

- Классы сущностей, такие как "Игрок" и "Монстр", реализованы в отдельных файлах (по желанию разработчика).

- Другие дополнительные файлы и классы, если они используются в проекте.

### Запуск проекта

Для запуска проекта необходимо склонировать репозиторий с GitHub и запустить проект в среде разработки, поддерживающей Swift и iOS, например, Xcode.

### Связь с автором

Для связи с автором проекта вы можете использовать Telegram: `@hetnoor`.
`daffixipop@gmail.com`

Приятной игры в "Emoji Battle"!


