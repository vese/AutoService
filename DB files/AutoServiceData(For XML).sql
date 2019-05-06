CREATE DATABASE AutoServiceData
GO
USE AutoServiceData
GO
CREATE TABLE [Make] (
	id int IDENTITY,
	name nvarchar(30) NOT NULL UNIQUE,
  CONSTRAINT [PK_MAKE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE TABLE [Model] (
	id int IDENTITY,
	name nvarchar(30) NOT NULL,
	make_id int NOT NULL,
  CONSTRAINT [PK_MODEL] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE TABLE [Transmission] (
	id int IDENTITY,
	name nvarchar(30) NOT NULL UNIQUE,
  CONSTRAINT [PK_TRANSMISSION] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE TABLE [Client] (
	id int IDENTITY,
	name nvarchar(30) NOT NULL,
	surname nvarchar(30) NULL,
	patronymic nvarchar(30) NULL,
	birth_year smallint NOT NULL,
	phone_number decimal(11) NOT NULL UNIQUE,
  CONSTRAINT [PK_CLIENT] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE TABLE [Work] (
	id int IDENTITY,
	name nvarchar(100) NOT NULL UNIQUE,
  CONSTRAINT [PK_WORK] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE TABLE [Car] (
	id int IDENTITY,
	model_id int NOT NULL,
	owner_id int NOT NULL,
	manufacturing_year smallint NOT NULL,
	transmission_id int NOT NULL,
	engine_power smallint NOT NULL,
  CONSTRAINT [PK_CAR] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE TABLE [Order] (
	id int IDENTITY,
	client_id int NOT NULL,
	car_id int NOT NULL,
	work_type_id int NOT NULL,
	start_date datetime NOT NULL,
	end_date datetime NULL,
	cost money NOT NULL,
  CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)
GO

ALTER TABLE [Model] WITH CHECK ADD CONSTRAINT [Model_fk0] FOREIGN KEY ([make_id]) REFERENCES [Make]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Model] CHECK CONSTRAINT [Model_fk0] 
GO

ALTER TABLE [Car] WITH CHECK ADD CONSTRAINT [Car_fk0] FOREIGN KEY ([model_id]) REFERENCES [Model]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Car] CHECK CONSTRAINT [Car_fk0]
GO

ALTER TABLE [Car] WITH CHECK ADD CONSTRAINT [Car_fk1] FOREIGN KEY ([owner_id]) REFERENCES [Client]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Car] CHECK CONSTRAINT [Car_fk1]
GO

ALTER TABLE [Car] WITH CHECK ADD CONSTRAINT [Car_fk2] FOREIGN KEY ([transmission_id]) REFERENCES [Transmission]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Car] CHECK CONSTRAINT [Car_fk2]
GO

ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT [Order_fk0] FOREIGN KEY ([car_id]) REFERENCES [Car]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Order] CHECK CONSTRAINT [Order_fk0] 
GO

ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT [Order_fk1] FOREIGN KEY ([client_id]) REFERENCES [Client]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Order] CHECK CONSTRAINT [Order_fk1]
GO

ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT [Order_fk2] FOREIGN KEY ([work_type_id]) REFERENCES [Work]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION
GO
ALTER TABLE [Order] CHECK CONSTRAINT [Order_fk2]
GO

INSERT INTO Transmission(name) VALUES ('Автоматическая'),('Механическая'),('Вариатор')
GO
INSERT INTO Make(name) VALUES ('Audi'),('BMW')
GO
INSERT INTO Model(name, make_id) VALUES
('A1', (SELECT id FROM Make WHERE name = 'Audi')),
('A2', (SELECT id FROM Make WHERE name = 'Audi')),
('A3', (SELECT id FROM Make WHERE name = 'Audi')),
('A4', (SELECT id FROM Make WHERE name = 'Audi')),
('A5', (SELECT id FROM Make WHERE name = 'Audi')),
('A6', (SELECT id FROM Make WHERE name = 'Audi')),
('A7', (SELECT id FROM Make WHERE name = 'Audi')),
('A8', (SELECT id FROM Make WHERE name = 'Audi')),
('i3', (SELECT id FROM Make WHERE name = 'BMW')),
('i8', (SELECT id FROM Make WHERE name = 'BMW')),
('X1', (SELECT id FROM Make WHERE name = 'BMW')),
('X3', (SELECT id FROM Make WHERE name = 'BMW')),
('X4', (SELECT id FROM Make WHERE name = 'BMW')),
('X5', (SELECT id FROM Make WHERE name = 'BMW')),
('X6', (SELECT id FROM Make WHERE name = 'BMW'))
GO
INSERT INTO Client(surname, name, patronymic, birth_year, phone_number) VALUES
('Боброва', 'Валерия', 'Потаповна', 1965, 78297759405),
('Устинов', 'Агап', 'Елизарович', 1979, 77798062300),
('Корепанов', 'Бронислав', 'Остапович', 1988, 78508343408),
('Бобрикова', 'Яна', 'Филипповна', 1994, 72979680491),
('Головнин', 'Евграф', 'Дмитриевич', 1979, 77837244228),
('Ныркова', 'Эмма', 'Степановна', 1960, 72366607976),
('Кушнарёва', 'Лиана', 'Феликсовна', 1963, 77226452338),
('Рыбакова', 'Христина', 'Юлиевна', 1958, 73878408501),
('Коржева', 'Маргарита', 'Юлиевна', 1985, 76731758100),
('Лялюшкина', 'Берта', 'Иосифовна', 1979, 72188907649),
('Листунова', 'Надежда', 'Филипповна', 1985, 71837120517),
('Янборисов', 'Евдоким', 'Родионович', 1998, 73041141724),
('Татаринцева', 'Дарья', 'Степановна', 1992, 74981335852),
('Белочкина', 'Мария', 'Данилевна', 1984, 79283728127),
('Кузьминыха', 'Алла', 'Федотовна', 1999, 72649765637),
('Мясников', 'Илья', 'Ипатиевич', 1989, 76022477311),
('Петрова', 'Алина', 'Владленовна', 1987, 77061825363),
('Танков', '?Август', 'Викентиевич', 1969, 73946198993),
('Ханинова', 'Валентина', 'Яновна',1977, 77766977819),
('Яковенко', 'Яна', 'Александровна', 1989, 71526928545),
('Портнов', 'Антип', 'Евгениевич', 1981, 78081121024),
('Кручинина', 'Екатерина', 'Виталиевна',1991, 72566936003),
('Тетерев', 'Захар', 'Титович', 1968, 76644805771),
('Эссена', 'Ольга', 'Евгениевна',1969, 72043795324),
('Букова', 'Оксана', 'Елизаровна', 1960, 71993077595),
('Хлебов', 'Лев', 'Евграфович', 1987, 71291578191),
('Аленин', 'Иосиф', 'Федотович', 1975, 71256864699),
('Вельдина', 'Агния', 'Казимировна', 1973, 72881398587),
('Якимычева', 'Наталия', 'Игнатиевна', 1966, 72156648867),
('Булдакова', 'Варвара', 'Афанасиевна',1962, 78319298818),
('Малиновский', 'Филипп', 'Тарасович',1979, 75138326212),
('Лобан', 'Тарас', 'Давыдович', 1989, 76454787410),
('Кошляк', 'Михаил', 'Брониславович',1968, 76435694447),
('Корепанов', 'Святослав', 'Эрнстович',1995, 78336617355),
('Ячменькова', 'Ариадна', 'Андрияновна',1961, 78684063904),
('Жернакова', 'Анисья', 'Глебовна', 1994, 77398139634),
('Лазуткина', 'Арина', 'Степановна', 1977, 71718548207),
('Штыкова', 'Милена', 'Тимофеевна', 1964, 75666175215),
('Дуванов', 'Лавр', 'Кондратович',1989, 75532124492),
('Долженко', 'Доминика', 'Борисовна', 1971, 78291868294)
GO
INSERT INTO Car(model_id, manufacturing_year, transmission_id, engine_power, owner_id) VALUES
((SELECT id FROM Model WHERE name = 'i3'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 24),
((SELECT id FROM Model WHERE name = 'X6'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 258, 15),
((SELECT id FROM Model WHERE name = 'A8'), 1994, (SELECT id FROM Transmission WHERE name = 'Механическая'), 174, 23),
((SELECT id FROM Model WHERE name = 'i8'), 2016, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 25),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 450, 14),
((SELECT id FROM Model WHERE name = 'A3'), 1996, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 125, 33),
((SELECT id FROM Model WHERE name = 'i3'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 39),
((SELECT id FROM Model WHERE name = 'A4'), 2015, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 34),
((SELECT id FROM Model WHERE name = 'X6'), 2008, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 235, 30),
((SELECT id FROM Model WHERE name = 'A2'), 2006, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 61, 32),
((SELECT id FROM Model WHERE name = 'X4'), 2016, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 28),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 381, 29),
((SELECT id FROM Model WHERE name = 'A5'), 2011, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 245, 35),
((SELECT id FROM Model WHERE name = 'A7'), 2012, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 310, 22),
((SELECT id FROM Model WHERE name = 'X1'), 2012, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 1),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Механическая'), 143, 27),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 177, 2),
((SELECT id FROM Model WHERE name = 'i3'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 9),
((SELECT id FROM Model WHERE name = 'i8'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 10),
((SELECT id FROM Model WHERE name = 'X1'), 2012, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 11),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 177, 12),
((SELECT id FROM Model WHERE name = 'X4'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 190, 13),
((SELECT id FROM Model WHERE name = 'A3'), 1996, (SELECT id FROM Transmission WHERE name = 'Механическая'), 101, 18),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 450, 4),
((SELECT id FROM Model WHERE name = 'A4'), 1995, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 125, 4),
((SELECT id FROM Model WHERE name = 'A5'), 2014, (SELECT id FROM Transmission WHERE name = 'Вариатор'), 204, 5),
((SELECT id FROM Model WHERE name = 'A6'), 1994, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 90, 6),
((SELECT id FROM Model WHERE name = 'A7'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 204, 7),
((SELECT id FROM Model WHERE name = 'i8'), 2016, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 40),
((SELECT id FROM Model WHERE name = 'A1'), 2011, (SELECT id FROM Transmission WHERE name = 'Механическая'), 90, 31),
((SELECT id FROM Model WHERE name = 'A3'), 2015, (SELECT id FROM Transmission WHERE name = 'Механическая'), 150, 3),
((SELECT id FROM Model WHERE name = 'A1'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 122, 1),
((SELECT id FROM Model WHERE name = 'A8'), 1998, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 150, 8),
((SELECT id FROM Model WHERE name = 'A1'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 140, 16),
((SELECT id FROM Model WHERE name = 'A2'), 2006, (SELECT id FROM Transmission WHERE name = 'Механическая'), 115, 17),
((SELECT id FROM Model WHERE name = 'X1'), 2013, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 26),
((SELECT id FROM Model WHERE name = 'A4'), 2001, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 180, 19),
((SELECT id FROM Model WHERE name = 'A5'), 2011, (SELECT id FROM Transmission WHERE name = 'Вариатор'), 190, 20),
((SELECT id FROM Model WHERE name = 'A6'), 2018, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 218, 21),
((SELECT id FROM Model WHERE name = 'A2'), 2007, (SELECT id FROM Transmission WHERE name = 'Механическая'), 115, 2),
((SELECT id FROM Model WHERE name = 'X4'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 190, 3),
((SELECT id FROM Model WHERE name = 'A8'), 2000, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 420, 38),
((SELECT id FROM Model WHERE name = 'A6'), 2016, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 36),
((SELECT id FROM Model WHERE name = 'A7'), 2018, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 333, 37),
((SELECT id FROM Model WHERE name = 'X6'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 258, 5)
GO
INSERT INTO Work(name) VALUES
('Регламентное ТО'),
('Ремонт коробок передач'),
('Обслуживание и ремонт двигателей'),
('Кузовной ремонт'),
('Ремонт ходовой части, балансировка, развал-схождения'),
('Ремонт электрики в машинах'),
('Обслуживание и ремонт кондиционеров в авто'),
('Шиномонтажные работы')
GO
GO
INSERT INTO [Order](client_id, car_id, work_type_id, start_date, end_date, cost) VALUES
(1,1,6, (convert(datetime,'2017-10-09 19:18:11', 120)), (convert(datetime,'2017-11-09 19:18:11', 120)),9776),
(2,2,3, (convert(datetime,'2018-10-03 03:51:02', 120)), (convert(datetime,'2018-11-03 03:51:02', 120)),930),
(3,3,6, (convert(datetime,'2015-08-17 03:28:38', 120)), (convert(datetime,'2015-09-17 03:28:38', 120)),5203),
(4,4,8, (convert(datetime,'2016-07-18 05:09:55', 120)), (convert(datetime,'2016-08-18 05:09:55', 120)),5561),
(5,5,2, (convert(datetime,'2017-04-12 01:22:23', 120)), (convert(datetime,'2017-05-12 01:22:23', 120)),6395),
(6,6,3, (convert(datetime,'2018-06-24 17:38:55', 120)), (convert(datetime,'2018-07-24 17:38:55', 120)),4653),
(7,7,1, (convert(datetime,'2015-07-12 21:29:59', 120)), (convert(datetime,'2015-08-12 21:29:59', 120)),2143),
(8,8,4, (convert(datetime,'2017-11-29 22:28:50', 120)), (convert(datetime,'2017-12-29 22:28:50', 120)),4738),
(9,9,6, (convert(datetime,'2018-12-10 05:02:35', 120)), (convert(datetime,'2018-12-30 05:02:35', 120)),1243),
(10,10,3, (convert(datetime,'2016-04-16 22:55:40', 120)), (convert(datetime,'2016-05-16 22:55:40', 120)),9974),
(11,11,4, (convert(datetime,'2018-03-23 16:43:41', 120)), (convert(datetime,'2018-04-23 16:43:41', 120)),1333),
(12,12,6, (convert(datetime,'2017-06-05 14:22:30', 120)), (convert(datetime,'2017-07-05 14:22:30', 120)),1000),
(13,13,7, (convert(datetime,'2018-07-04 01:54:42', 120)), (convert(datetime,'2018-08-04 01:54:42', 120)),7000),
(14,14,2, (convert(datetime,'2018-05-05 14:53:38', 120)), (convert(datetime,'2018-06-05 14:53:38', 120)),6550),
(15,15,1, (convert(datetime,'2015-09-26 18:51:00', 120)), (convert(datetime,'2015-10-26 18:51:00', 120)),550),
(16,16,2, (convert(datetime,'2017-04-25 08:14:20', 120)), (convert(datetime,'2017-05-25 08:14:20', 120)),900),
(17,17,3, (convert(datetime,'2017-08-03 21:33:28', 120)), (convert(datetime,'2017-09-03 21:33:28', 120)),3424),
(18,18,4, (convert(datetime,'2017-05-03 20:50:35', 120)), (convert(datetime,'2017-06-03 20:50:35', 120)),1900),
(19,19,5, (convert(datetime,'2015-04-07 05:15:01', 120)), (convert(datetime,'2015-05-07 05:15:01', 120)),9000),
(20,20,6, (convert(datetime,'2015-10-04 00:13:53', 120)), (convert(datetime,'2015-11-04 00:13:53', 120)),5000),
(21,21,7, (convert(datetime,'2017-04-26 12:17:43', 120)), (convert(datetime,'2017-05-26 12:17:43', 120)),3050),
(22,22,8, (convert(datetime,'2016-04-22 18:48:58', 120)), (convert(datetime,'2016-05-22 18:48:58', 120)),4560),
(23,23,1, (convert(datetime,'2016-08-03 11:35:25', 120)), (convert(datetime,'2016-09-03 11:35:25', 120)),600),
(24,24,2, (convert(datetime,'2017-06-04 01:59:48', 120)), (convert(datetime,'2017-07-04 01:59:48', 120)),700),
(25,25,3, (convert(datetime,'2016-08-21 09:55:12', 120)), (convert(datetime,'2016-09-21 09:55:12', 120)),1200),
(26,26,4, (convert(datetime,'2017-08-24 11:00:54', 120)), (convert(datetime,'2017-09-24 11:00:54', 120)),5600),
(27,27,5, (convert(datetime,'2015-07-12 09:08:56', 120)), (convert(datetime,'2015-08-12 09:08:56', 120)),8800),
(28,28,6, (convert(datetime,'2017-03-01 22:25:07', 120)), (convert(datetime,'2017-04-01 22:25:07', 120)),3000),
(29,29,7, (convert(datetime,'2016-08-22 15:30:46', 120)), (convert(datetime,'2016-09-22 15:30:46', 120)),3000),
(30,30,8, (convert(datetime,'2018-09-03 05:36:29', 120)), (convert(datetime,'2018-10-03 05:36:29', 120)),5080),
(31,31,8, (convert(datetime,'2015-04-21 20:33:46', 120)), (convert(datetime,'2015-05-21 20:33:46', 120)),9510),
(32,32,7, (convert(datetime,'2016-10-01 05:06:01', 120)), (convert(datetime,'2016-11-01 05:06:01', 120)),3000),
(33,33,6, (convert(datetime,'2016-09-14 14:00:55', 120)), (convert(datetime,'2016-10-14 14:00:55', 120)),3000),
(34,34,5, (convert(datetime,'2018-07-08 05:50:09', 120)), (convert(datetime,'2018-08-08 05:50:09', 120)),6660),
(35,35,4, (convert(datetime,'2017-05-29 04:00:40', 120)), (convert(datetime,'2017-06-29 04:00:40', 120)),6650),
(36,36,3, (convert(datetime,'2018-05-02 14:03:08', 120)), (convert(datetime,'2018-06-02 14:03:08', 120)),640),
(37,37,2, (convert(datetime,'2018-09-24 15:48:11', 120)), (convert(datetime,'2018-10-24 15:48:11', 120)),9970),
(38,38,1, (convert(datetime,'2017-02-26 00:59:50', 120)), (convert(datetime,'2017-03-26 00:59:50', 120)),4300),
(39,39,2, (convert(datetime,'2018-07-16 15:35:30', 120)), null,800),
(40,40,3, (convert(datetime,'2018-10-07 03:07:29', 120)), (convert(datetime,'2018-11-07 03:07:29', 120)),900),
(1,41,4, (convert(datetime,'2015-11-25 04:15:13', 120)), (convert(datetime,'2015-12-25 04:15:13', 120)),1000),
(2,42,5, (convert(datetime,'2016-04-12 10:17:07', 120)), (convert(datetime,'2016-05-12 10:17:07', 120)),2000),
(3,43,6, (convert(datetime,'2018-11-30 15:29:30', 120)), null,3000),
(4,44,7, (convert(datetime,'2018-07-31 02:39:58', 120)), null,4000),
(5,45,8, (convert(datetime,'2016-11-22 11:17:48', 120)), (convert(datetime,'2016-12-22 11:17:48', 120)),5000),
(4,44,8, (convert(datetime,'2018-01-07 05:16:54', 120)), (convert(datetime,'2018-02-07 05:16:54', 120)),6000),
(5,5,8, (convert(datetime,'2018-06-02 09:22:48', 120)), (convert(datetime,'2018-07-02 09:22:48', 120)),7000),
(6,6,7, (convert(datetime,'2017-11-24 13:39:58', 120)), (convert(datetime,'2017-12-24 13:39:58', 120)),8000),
(7,7,6, (convert(datetime,'2016-08-20 19:33:18', 120)), (convert(datetime,'2016-09-20 19:33:18', 120)),9000),
(8,8,2, (convert(datetime,'2017-11-27 10:13:53', 120)), (convert(datetime,'2017-12-27 10:13:53', 120)),9500)