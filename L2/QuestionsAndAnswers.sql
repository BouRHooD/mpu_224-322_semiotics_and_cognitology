/*
  Для занесения данных в *.db, необходимо запустить приложение, тогда при инициализации БД запуститься данный файл
  <Все> - Подходят все варианты ответов, кроме "Не знаю"
  [Поле ввода текста] - Подходят все варианты ответов, кроме "Не знаю"
*/

DROP TABLE IF EXISTS QuestTable;
DROP TABLE IF EXISTS AnswTable;
DROP TABLE IF EXISTS QuestRulesTable;
DROP TABLE IF EXISTS RulesSimpleTable;

CREATE TABLE QuestTable       (ID INTEGER PRIMARY KEY, question TEXT, answers TEXT, parameter TEXT, ignored INTEGER, imagePath TEXT);
CREATE TABLE AnswTable        (ID INTEGER PRIMARY KEY, nameAuto TEXT, priceAuto INTEGER, countryAuto TEXT, carBodyType TEXT, clearanceAuto INTEGER, yearAuto INTEGER, fuelСonsumptionAuto INTEGER, transmissionType TEXT, engineType TEXT, engineСapacity TEXT, wheelDriveType TEXT, trunkVolume INTEGER, imagePath TEXT);
CREATE TABLE QuestRulesTable  (ID INTEGER PRIMARY KEY, IF_Par TEXT, If_Value TEXT, nextQuestId INTEGER);
CREATE TABLE RulesSimpleTable (ID INTEGER PRIMARY KEY, IF_Par TEXT, IF_Value TEXT, Rule TEXT);

/*QuestTable-------------------ID,  question,                                                          answers,                                                    parameter,                        ignored, imagePath*/
INSERT INTO QuestTable VALUES (0,  'Какой должна быть максимальная цена автомобиля в рублях?',        '200000;300000;400000;500000;600000;700000;800000;900000',  'max_priceAuto',                  0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (1,  'Какой страны Вы предпочитаете автомобиль?',                       'Россия;Франция;Не знаю',                                   'select_countryAuto',             0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (2,  'Какой должен быть кузов в автомобиле?',                           'Седан;Внедорожник;Лифтбек;Универсал;Хетчбек;Купе;Не знаю', 'select_carBodyType',             0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (3,  'Если автомобиль планируется использовать для рыбалки/охоты, то для отличного прохождения бездорожья вам подойдет "Внедорожник". Нравится ли вам тип кузова "Внедорожник"?',                                                                              'Да;Нет;Не знаю', 'select_carBodyType_like_vnedorojnik', 1, 'Images/QuestionsImages/Внедорожник.png');
INSERT INTO QuestTable VALUES (4,  'В типе кузова "Седан" моторный и багажный отдел разделены друг от друга, крыша без резких углов переходит в заднюю дверцу. Нравится ли вам тип кузова "Седан"?',                                                                                         'Да;Нет;Не знаю', 'select_carBodyType_like_sedan',       1, 'Images/QuestionsImages/Седан.png');
INSERT INTO QuestTable VALUES (5,  'Тип кузова "Лифтбек" является одной из вариаций "Хетчбека". Слово “liftback” означает “поднимающаяся задняя часть”. В отличии от хетчбека, лифтбек имеет более длинный задний свес, а крышка багажник здесь более пологая либо ступенчатая, чем-то напоминающая седан. Также это предполагает, что лифтбек менее удобен для перевозки грузов. Нравится ли вам тип кузова "Лифтбек"?', 'Да;Нет;Не знаю', 'select_carBodyType_like_liftbek', 1, 'Images/QuestionsImages/Лифтбек.png');
INSERT INTO QuestTable VALUES (6,  'Тип кузова "Универсал" является грузопассажирским кузовом на основе седана с дверью в задке, задний свес как у седана или длиннее. Нравится ли вам тип кузова "Универсал"?',                                                                             'Да;Нет;Не знаю', 'select_carBodyType_like_universal',   1, 'Images/QuestionsImages/Универсал.png');
INSERT INTO QuestTable VALUES (7,  'Тип кузова "Хетчбек" является родственником универсала, но отличается меньшей длиной заднего свеса, соответственно, менее грузоподъёмен. Нравится ли вам тип кузова "Хетчбек"?',                                                                         'Да;Нет;Не знаю', 'select_carBodyType_like_hetcbek',     1, 'Images/QuestionsImages/Хетчбек.png');
INSERT INTO QuestTable VALUES (8,  'Тип кузова "Купе" имеет всего по одной двери с каждого борта, и это — обязательное условие. Спортивный и представительский вид, привлекает взгляды окружающих людей. Хорошие динамические качества и управляемость. Нравится ли вам тип кузова "Купе"?', 'Да;Нет;Не знаю', 'select_carBodyType_like_kupe',        1, 'Images/QuestionsImages/Купе.png');
INSERT INTO QuestTable VALUES (9,  'Какой должен быть минимальный клиренс автомобиля в мм?',          '[Поле ввода текста];[Кнопка-Не знаю]',                      'select_clearanceAuto',          0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (10, 'Вы планируете ездить по бездорожью или по местам, где много ям?', 'Да;Нет;Не знаю',                                            'select_clearanceAuto_like_pit', 1,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (11, 'Какой минимальный год выпуска автомобиля должен быть?',           '[Поле ввода текста];[Кнопка-Не знаю]',                      'min_yearAuto',                  0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (12, 'Какой максимальный расход топлива должен быть (в литрах)?',       '[Поле ввода текста];[Кнопка-Не знаю]',                      'max_fuelСonsumptionAuto',       0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (13, 'Какой должна быть коробка передач?',                              'Механическая;Автоматическая;Робот;Вариатор;Не знаю',        'select_transmissionType',       0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (14, 'Какой тип двигателя должен быть в автомобиле?',                   'Бензин;Дизель;Не знаю',                                     'select_engineType',             0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (15, 'Какой максимальный объем двигателя (в литрах)?',                  '1.1;1.4;1.5;1.6;1.9;2;2.2;2.3;2.7;3;Не знаю',               'select_engineСapacity',         0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (16, 'Какой привод должен быть в автомобиле?',                          'Передний;Задний;Полный;Не знаю',                            'select_wheelDriveType',         0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (17, '"Передний" привод - когда двигатель вращает только передние колеса. Плюсы: увеличенная площадь салона за счет отсутствия карданного вала; меньше цена; улучшенная управляемость на дорогах (передние колеса тащат на себе весь груз, а значит, у авто выше курсовая устойчивость). Минусы: долгий разгон. Вам нравится "Передний" привод?', 'Да;Нет;Не знаю', 'select_wheelDriveType_like_forwward', 1, 'Images/QuestionsImages/Передний привод.png');
INSERT INTO QuestTable VALUES (18, '"Задний" привод - когда двигатель вращает только задние колеса. Плюсы: быстрее на старте, меньше радиус разворота (благодаря более простой конструкции подвески передних колес). Минусы: сложность управления в галолед, высокая цена. Вам нравится "Задний" привод?',                                                                      'Да;Нет;Не знаю', 'select_wheelDriveType_like_backward', 1, 'Images/QuestionsImages/Задний привод.png');
INSERT INTO QuestTable VALUES (19, '"Полный" привод - когда двигатель вращает все четыре колеса. Плюсы: улучшенная управляемость, безопасность и стабильность автомобиля при движении (даже по бездорожью). Минусы: повышенный расход топлива, увеличение веса автомобиля, дорогое обслуживание. Вам нравится "Полный" привод?',                                                'Да;Нет;Не знаю', 'select_wheelDriveType_like_full',     1, 'Images/QuestionsImages/Полный привод.png');
INSERT INTO QuestTable VALUES (20, 'Какой должен быть минимальный объем багажника в литрах?',         '[Поле ввода текста];[Кнопка-Не знаю]',                      'select_trunkVolume',            0,       'Images/QuestionsImages/');
INSERT INTO QuestTable VALUES (21, 'Вы планируете перевозить габаритные вещи в багажнике (каляски/походные вещи/маленький холодильник)?', 'Да;Нет;Не знаю',        'select_trunkVolume_like_big',   1,       'Images/QuestionsImages/');

/*AnswTable-------------------ID, nameAuto,                       priceAuto, countryAuto, carBodyType,                       clearanceAuto, yearAuto, fuelСonsumptionAuto, transmissionType,                        engineType,      engineСapacity,      wheelDriveType,    trunkVolume, imagePath*/
INSERT INTO AnswTable VALUES (0,  'Renault Megane II',            300000,    'Франция',   'Седан;Хетчбек',                   125,           2002,     11,                  'Механическая;Автоматическая',           'Бензин;Дизель', "1.4;1.5;1.6;1.9;2", 'Передний',        520,         'Images/AnswersImages/Renault Megane II.png');
INSERT INTO AnswTable VALUES (1,  'Renault Megane II Рестайлинг', 450000,    'Франция',   'Седан;Универсал',                 150,           2006,     10,                  'Механическая;Автоматическая',           'Бензин;Дизель', "1.4;1.5;1.6;1.9;2", 'Передний',        520,         'Images/AnswersImages/Renault Megane II Рестайлинг.png');
INSERT INTO AnswTable VALUES (2,  'Renault Kaptur I',             900000,    'Франция',   'Внедорожник',                     204,           2016,     11,                  'Механическая;Автоматическая;Вариатор;', 'Бензин',        "1.6;2",             'Передний;Полный', 1200,        'Images/AnswersImages/Renault Kaptur I.png');
INSERT INTO AnswTable VALUES (3,  'Peugeot 206',                  250000,    'Франция',   'Хэтчбек',                         110,           2006,     9,                   'Механическая;Автоматическая',           'Бензин',        "1.1;1.4;1.6;2",     'Передний',        1130,        'Images/AnswersImages/Peugeot 206.png');
INSERT INTO AnswTable VALUES (4,  'Peugeot 407',                  750000,    'Франция',   'Купе',                            110,           2004,     12,                  'Механическая;Автоматическая',           'Бензин;Дизель', "2.2;2.7;3",         'Передний',        400,         'Images/AnswersImages/Peugeot 407.png');
INSERT INTO AnswTable VALUES (5,  'Lada (ВАЗ) Priora I',          250000,    'Россия',    'Купе;Седан;Универсал;Хетчбек',    165,           2007,     9,                   'Механическая',                          'Бензин',        "1.6",               'Передний',        705,         'Images/AnswersImages/Lada (ВАЗ) Priora I.jpg');
INSERT INTO AnswTable VALUES (6,  'Lada (ВАЗ) Granta',            400000,    'Россия',    'Седан;Лифтбек;Универсал;Хетчбек', 160,           2011,     9,                   'Механическая;Автоматическая;Робот',     'Бензин',        "1.6",               'Передний',        480,         'Images/AnswersImages/Lada (ВАЗ) Granta.png');
INSERT INTO AnswTable VALUES (7,  'Vortex Estina I',              200000,    'Россия',    'Седан',                           124,           2008,     9,                   'Механическая',                          'Бензин',        "1.5;1.6;2",         'Передний',        500,         'Images/AnswersImages/Vortex Estina I.png');
INSERT INTO AnswTable VALUES (8,  'Vortex Tingo I',               350000,    'Россия',    'Внедорожник',                     190,           2010,     12,                  'Механическая;Робот',                    'Бензин',        "1.9;",              'Передний',        500,         'Images/AnswersImages/Vortex Tingo I.png');
INSERT INTO AnswTable VALUES (9,  'УАЗ Patriot I',                400000,    'Россия',    'Внедорожник',                     210,           2005,     15,                  'Механическая',                          'Бензин;Дизель', "2.3;2.7",           'Полный',          1850,        'Images/AnswersImages/УАЗ Patriot I.png');
INSERT INTO AnswTable VALUES (10, 'УАЗ Patriot I Рестайлинг 1',   600000,    'Россия',    'Внедорожник',                     210,           2012,     15,                  'Механическая',                          'Бензин;Дизель', "2.2;2.7",           'Полный',          1850,        'Images/AnswersImages/УАЗ Patriot I Рестайлинг 1.png');
INSERT INTO AnswTable VALUES (11, 'УАЗ Patriot I Рестайлинг 2',   850000,    'Россия',    'Внедорожник',                     190,           2014,     15,                  'Механическая',                          'Бензин',        "2.2;2.7",           'Полный',          1850,        'Images/AnswersImages/УАЗ Patriot I Рестайлинг 2.png');

/*QuestRulesTable--------------------------------------------------IF_Par,                                If_Value,              nextQuestId*/
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('max_priceAuto',                       '<Все>',               1);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_countryAuto',                  '<Все>',               2);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType',                  '<Все>',               9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType',                  'Не знаю',             3);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_vnedorojnik', 'Да',                  9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_vnedorojnik', 'Нет',                 4);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_vnedorojnik', 'Не знаю',             4);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_sedan',       'Да',                  9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_sedan',       'Нет',                 5);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_sedan',       'Не знаю',             5);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_liftbek',     'Да',                  9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_liftbek',     'Нет',                 6);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_liftbek',     'Не знаю',             6);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_universal',   'Да',                  9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_universal',   'Нет',                 7);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_universal',   'Не знаю',             7);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_hetcbek',     'Да',                  9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_hetcbek',     'Нет',                 8);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_hetcbek',     'Не знаю',             8);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_kupe',        'Да',                  9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_kupe',        'Нет',                 9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_carBodyType_like_kupe',        'Не знаю',             9);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_clearanceAuto',                '[Поле ввода текста]', 11);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_clearanceAuto',                'Не знаю',             10);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_clearanceAuto_like_pit',       'Да',                  11);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_clearanceAuto_like_pit',       'Нет',                 11);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_clearanceAuto_like_pit',       'Не знаю',             11);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('min_yearAuto',                        '[Поле ввода текста]', 12);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('max_fuelСonsumptionAuto',             '[Поле ввода текста]', 13);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_transmissionType',             '<Все>',               14);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_engineType',                   '<Все>',               15);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_engineСapacity',               '<Все>',               16);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType',               '<Все>',               20);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType',               'Не знаю',             17);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_forwward', 'Да',                  20);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_forwward', 'Нет',                 18);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_forwward', 'Не знаю',             18);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_backward', 'Да',                  20);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_backward', 'Нет',                 19);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_backward', 'Не знаю',             19);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_full',     'Да',                  20);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_full',     'Нет',                 20);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_wheelDriveType_like_full',     'Не знаю',             20);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_trunkVolume',                  '<Все>',               -1);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_trunkVolume',                  'Не знаю',             21);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_trunkVolume_like_big',         'Да',                  -1);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_trunkVolume_like_big',         'Нет',                 -1);
INSERT INTO QuestRulesTable(IF_Par, If_Value, nextQuestId) VALUES ('select_trunkVolume_like_big',         'Не знаю',             -1);

/*RulesSimpleTable-------------------------------------------IF_Par,                                IF_Value,              Rule*/
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('max_priceAuto',                       '<Все>',               'DELETE FROM AnswTable WHERE priceAuto > {}'                                                                                     );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_countryAuto',                  '<Все>',               'DELETE FROM AnswTable WHERE countryAuto NOT LIKE "%{}%"'                                                                        );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType',                  '<Все>',               'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%{}%"'                                                                        );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType',                  'Не знаю',             'UPDATE QuestTable SET ignored = 0 WHERE id in (3, 4, 5, 6, 7, 8)'                                                               );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType_like_vnedorojnik', 'Да',                  'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%Внедорожник%";UPDATE QuestTable SET ignored = 1 WHERE id in (4, 5, 6, 7, 8)' );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType_like_sedan',       'Да',                  'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%Седан%";UPDATE QuestTable SET ignored = 1 WHERE id in (5, 6, 7, 8)'          );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType_like_liftbek',     'Да',                  'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%Лифтбек%";UPDATE QuestTable SET ignored = 1 WHERE id in (6, 7, 8)'           );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType_like_universal',   'Да',                  'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%Универсал%";UPDATE QuestTable SET ignored = 1 WHERE id in (7, 8)'            );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType_like_hetcbek',     'Да',                  'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%Хетчбек%";UPDATE QuestTable SET ignored = 1 WHERE id = 8'                    );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_carBodyType_like_kupe',        'Да',                  'DELETE FROM AnswTable WHERE carBodyType NOT LIKE "%Купе%"'                                                                      );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_clearanceAuto',                '[Поле ввода текста]', 'DELETE FROM AnswTable WHERE clearanceAuto < {}'                                                                                 );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_clearanceAuto',                'Не знаю',             'UPDATE QuestTable SET ignored = 0 WHERE id = 10'                                                                                );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_clearanceAuto_like_pit',       'Да',                  'DELETE FROM AnswTable WHERE clearanceAuto < 190'                                                                                );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('min_yearAuto',                        '[Поле ввода текста]', 'DELETE FROM AnswTable WHERE yearAuto < {}'                                                                                      );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('max_fuelСonsumptionAuto',             '[Поле ввода текста]', 'DELETE FROM AnswTable WHERE fuelСonsumptionAuto > {}'                                                                           );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_transmissionType',             '<Все>',               'DELETE FROM AnswTable WHERE transmissionType NOT LIKE "%{}%"'                                                                   );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_engineType',                   '<Все>',               'DELETE FROM AnswTable WHERE engineType NOT LIKE "%{}%"'                                                                         );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_engineСapacity',               '<Все>',               'DELETE FROM AnswTable WHERE engineСapacity NOT LIKE "%{}%"'                                                                     );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_wheelDriveType',               '<Все>',               'DELETE FROM AnswTable WHERE wheelDriveType NOT LIKE "%{}%"'                                                                     );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_wheelDriveType',               'Не знаю',             'UPDATE QuestTable SET ignored = 0 WHERE id in (17, 18, 19)'                                                                     );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_wheelDriveType_like_forwward', 'Да',                  'DELETE FROM AnswTable WHERE wheelDriveType NOT LIKE "%Передний%";UPDATE QuestTable SET ignored = 1 WHERE id in (18, 19)'        );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_wheelDriveType_like_backward', 'Да',                  'DELETE FROM AnswTable WHERE wheelDriveType NOT LIKE "%Задний%";UPDATE QuestTable SET ignored = 1 WHERE id = 19'                 );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_wheelDriveType_like_full',     'Да',                  'DELETE FROM AnswTable WHERE wheelDriveType NOT LIKE "%Полный%"'                                                                 );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_trunkVolume',                  '<Все>',               'DELETE FROM AnswTable WHERE trunkVolume < {}'                                                                                   );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_trunkVolume',                  'Не знаю',             'UPDATE QuestTable SET ignored = 0 WHERE id = 21'                                                                                );
INSERT INTO RulesSimpleTable(IF_Par, IF_Value, Rule) VALUES ('select_trunkVolume_like_big',         'Да',                  'DELETE FROM AnswTable WHERE trunkVolume < 1100'                                                                                 );




