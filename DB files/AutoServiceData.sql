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
('Ямских', 'Никита', 'Трофимович', 1965, 78297759405),
('Никишин', 'Терентий', 'Алексеевич', 1979, 77798062300),
('Вырыпаев', 'Кондратий', 'Михаилович', 1988, 78508343408),
('Успенский', 'Богдан', 'Панкратиевич', 1994, 72979680491),
('Клюкина', '?Агата', 'Глебовна', 1979, 77837244228),
('Меликова', 'Ангелина', 'Святославовна',1960, 72366607976),
('Шитов', 'Тарас', 'Давидович', 1963, 77226452338),
('Лассмана', 'Клара', 'Борисовна', 1985, 76731758100),
('Калинин', 'Герасим', 'Никонович',1979, 72188907649),
('Дёгтин', 'Лука', 'Онисимович', 1958, 73878408501),
('Фунтусова', 'Тамара', 'Борисовна', 1985, 71837120517),
('Суснина', 'Наталия', 'Тимуровна', 1998, 73041141724),
('Кологреева', 'Марина', 'Павеловна', 1992, 74981335852),
('Бурцев', 'Карл', 'Иннокентиевич', 1984, 79283728127),
('Мозговой', 'Галина', 'Давидовна', 1999, 72649765637),
('Шлыков', 'Демьян', 'Мирославович', 1989, 76022477311),
('Витковский', 'Валерий', 'Андреевич', 1987, 77061825363),
('Муратов', 'Осип', 'Филимонович', 1969, 73946198993),
('Хесман', 'Парфен', 'Евлампиевич', 1977, 77766977819),
('Астрединов', 'Станислав', 'Потапович', 1989, 71526928545),
('Браило', 'Денис', 'Макарович', 1981, 78081121024),
('Репин', 'Елизар', 'Мартьянович', 1991, 72566936003),
('Вольпова', 'Альбина', 'Елизаровна', 1968, 76644805771),
('Эмскиха', 'Эмилия', 'Андрияновна', 1969, 72043795324),
('Собаков', 'Глеб', 'Прохорович', 1960, 71993077595),
('Ажищенкова', 'Юлия', 'Серафимовна', 1987, 71291578191),
('Ивазова', 'Софья', 'Андрияновна', 1975, 71256864699),
('Капица', 'Алиса', 'Брониславовна', 1973, 72881398587),
('Шушалева', 'Любава', 'Алексеевна', 1966, 72156648867),
('Любимов', 'Демьян', 'Ермолаевич', 1962, 78319298818),
('Васютин', 'Онуфрий', 'Ипатович', 1979, 75138326212),
('Мазаев', 'Мирослав', 'Иннокентиевич', 1989, 76454787410),
('Шулёва', 'Дарья', 'Евгениевна', 1968, 76435694447),
('Дудко', 'Доминика', 'Мефодиевна', 1995, 78336617355),
('Сиясинова', 'Любовь', 'Михеевна', 1961, 78684063904),
('Набоков', 'Карл', 'Родионович', 1994, 77398139634),
('Николаенко', 'Иван', 'Александрович', 1977, 71718548207),
('Яковенко', 'Ангелина', 'Юлиевна', 1964, 75666175215),
('Верещагин', 'Серафим', 'Юриевич', 1989, 75532124492),
('Мутовина', 'Элеонора', 'Кузьмевна',1971, 78291868294)
GO
INSERT INTO Car(model_id, manufacturing_year, transmission_id, engine_power, owner_id) VALUES
((SELECT id FROM Model WHERE name = 'X4'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 190, 13),
((SELECT id FROM Model WHERE name = 'i3'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 24),
((SELECT id FROM Model WHERE name = 'A7'), 2012, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 310, 22),
((SELECT id FROM Model WHERE name = 'A8'), 2000, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 420, 38),
((SELECT id FROM Model WHERE name = 'X4'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 190, 3),
((SELECT id FROM Model WHERE name = 'A6'), 1994, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 90, 6),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 450, 14),
((SELECT id FROM Model WHERE name = 'i3'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 39),
((SELECT id FROM Model WHERE name = 'i3'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 9),
((SELECT id FROM Model WHERE name = 'A2'), 2006, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 61, 32),
((SELECT id FROM Model WHERE name = 'A5'), 2014, (SELECT id FROM Transmission WHERE name = 'Вариатор'), 204, 5),
((SELECT id FROM Model WHERE name = 'A8'), 1994, (SELECT id FROM Transmission WHERE name = 'Механическая'), 174, 23),
((SELECT id FROM Model WHERE name = 'A4'), 2015, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 34),
((SELECT id FROM Model WHERE name = 'X6'), 2008, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 235, 30),
((SELECT id FROM Model WHERE name = 'A1'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 122, 1),
((SELECT id FROM Model WHERE name = 'A8'), 1998, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 150, 8),
((SELECT id FROM Model WHERE name = 'i8'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 10),
((SELECT id FROM Model WHERE name = 'X4'), 2016, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 28),
((SELECT id FROM Model WHERE name = 'X1'), 2012, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 11),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 177, 12),
((SELECT id FROM Model WHERE name = 'A3'), 1996, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 125, 33),
((SELECT id FROM Model WHERE name = 'X1'), 2012, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 1),
((SELECT id FROM Model WHERE name = 'A4'), 1995, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 125, 4),
((SELECT id FROM Model WHERE name = 'X6'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 258, 15),
((SELECT id FROM Model WHERE name = 'A6'), 2018, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 218, 21),
((SELECT id FROM Model WHERE name = 'A2'), 2007, (SELECT id FROM Transmission WHERE name = 'Механическая'), 115, 2),
((SELECT id FROM Model WHERE name = 'A3'), 2015, (SELECT id FROM Transmission WHERE name = 'Механическая'), 150, 3),
((SELECT id FROM Model WHERE name = 'i8'), 2016, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 40),
((SELECT id FROM Model WHERE name = 'A1'), 2011, (SELECT id FROM Transmission WHERE name = 'Механическая'), 90, 31),
((SELECT id FROM Model WHERE name = 'A2'), 2006, (SELECT id FROM Transmission WHERE name = 'Механическая'), 115, 17),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 450, 4),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Механическая'), 143, 27),
((SELECT id FROM Model WHERE name = 'X1'), 2013, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 26),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 381, 29),
((SELECT id FROM Model WHERE name = 'A5'), 2011, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 245, 35),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 177, 2),
((SELECT id FROM Model WHERE name = 'A7'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 204, 7),
((SELECT id FROM Model WHERE name = 'A5'), 2011, (SELECT id FROM Transmission WHERE name = 'Вариатор'), 190, 20),
((SELECT id FROM Model WHERE name = 'i8'), 2016, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 25),
((SELECT id FROM Model WHERE name = 'A6'), 2016, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 36),
((SELECT id FROM Model WHERE name = 'A4'), 2001, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 180, 19),
((SELECT id FROM Model WHERE name = 'A1'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 140, 16),
((SELECT id FROM Model WHERE name = 'A3'), 1996, (SELECT id FROM Transmission WHERE name = 'Механическая'), 101, 18),
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
(1,1,8, (convert(datetime,'2017-07-20 11:55:49', 120)), (convert(datetime,'2017-08-20 11:55:49', 120)),1233),
(2,2,7, (convert(datetime,'2018-03-23 22:09:45', 120)), (convert(datetime,'2018-04-23 22:09:45', 120)),1233),
(3,3,6, (convert(datetime,'2018-04-22 14:26:56', 120)), (convert(datetime,'2018-05-22 14:26:56', 120)),4000),
(4,4,5, (convert(datetime,'2016-08-26 06:35:41', 120)), (convert(datetime,'2016-09-26 06:35:41', 120)),1200),
(5,5,4, (convert(datetime,'2015-11-19 06:56:15', 120)), (convert(datetime,'2015-12-19 06:56:15', 120)),1200),
(6,6,3, (convert(datetime,'2016-08-28 03:19:28', 120)), (convert(datetime,'2016-09-28 03:19:28', 120)),1200),
(7,7,2, (convert(datetime,'2017-11-15 09:09:57', 120)), (convert(datetime,'2017-12-15 09:09:57', 120)),1200),
(8,8,1, (convert(datetime,'2016-10-20 17:11:58', 120)), (convert(datetime,'2016-11-20 17:11:58', 120)),1200),
(9,9,1, (convert(datetime,'2017-01-22 21:33:14', 120)), (convert(datetime,'2017-02-22 21:33:14', 120)),1200),
(10,10,2, (convert(datetime,'2016-02-20 02:15:18', 120)), (convert(datetime,'2016-03-20 02:15:18', 120)),4400),
(11,11,3, (convert(datetime,'2018-03-19 01:19:07', 120)), (convert(datetime,'2018-04-19 01:19:07', 120)),4500),
(12,12,4, (convert(datetime,'2016-05-24 10:32:43', 120)), (convert(datetime,'2016-06-24 10:32:43', 120)),1100),
(13,13,5, (convert(datetime,'2015-07-23 00:40:36', 120)), (convert(datetime,'2015-08-23 00:40:36', 120)),500),
(14,14,6, (convert(datetime,'2018-06-29 13:22:00', 120)), (convert(datetime,'2018-07-29 13:22:00', 120)),900),
(15,15,7, (convert(datetime,'2015-10-18 07:23:18', 120)), (convert(datetime,'2015-11-18 07:23:18', 120)),900),
(16,16,8, (convert(datetime,'2017-11-23 04:10:28', 120)), (convert(datetime,'2017-12-23 04:10:28', 120)),1000),
(17,17,8, (convert(datetime,'2016-02-03 09:03:34', 120)), (convert(datetime,'2016-03-03 09:03:34', 120)),9000),
(18,18,7, (convert(datetime,'2016-11-25 06:08:00', 120)), (convert(datetime,'2016-12-25 06:08:00', 120)),8000),
(19,19,6, (convert(datetime,'2018-06-22 11:47:00', 120)), (convert(datetime,'2018-07-22 11:47:00', 120)),7000),
(20,20,5, (convert(datetime,'2017-03-15 01:41:21', 120)), (convert(datetime,'2017-04-15 01:41:21', 120)),6000),
(21,21,4, (convert(datetime,'2017-03-14 11:23:41', 120)), (convert(datetime,'2017-04-14 11:23:41', 120)),5000),
(22,22,3, (convert(datetime,'2018-10-21 03:48:40', 120)), (convert(datetime,'2018-11-21 03:48:40', 120)),4000),
(23,23,3, (convert(datetime,'2018-09-18 10:47:09', 120)), (convert(datetime,'2018-10-18 10:47:09', 120)),4999),
(24,24,2, (convert(datetime,'2015-06-25 22:54:29', 120)), (convert(datetime,'2015-07-25 22:54:29', 120)),3000),
(25,25,1, (convert(datetime,'2018-04-11 00:59:43', 120)), null,2000),
(26,26,1, (convert(datetime,'2016-10-11 04:47:29', 120)), (convert(datetime,'2016-11-11 04:47:29', 120)),2500),
(27,27,2, (convert(datetime,'2018-07-28 23:19:19', 120)), (convert(datetime,'2018-08-28 23:19:19', 120)),2600),
(28,28,3, (convert(datetime,'2018-01-07 16:41:17', 120)), (convert(datetime,'2018-02-07 16:41:17', 120)),2700),
(29,29,3, (convert(datetime,'2015-07-29 05:10:57', 120)), (convert(datetime,'2015-08-29 05:10:57', 120)),3000),
(30,30,4, (convert(datetime,'2015-04-21 19:37:08', 120)), (convert(datetime,'2015-05-21 19:37:08', 120)),500),
(31,31,5, (convert(datetime,'2017-08-17 12:03:44', 120)), (convert(datetime,'2017-09-17 12:03:44', 120)),600),
(32,32,6, (convert(datetime,'2016-07-08 20:35:42', 120)), (convert(datetime,'2016-08-08 20:35:42', 120)),600),
(33,33,7, (convert(datetime,'2017-12-15 15:24:30', 120)), (convert(datetime,'2017-12-30 15:24:30', 120)),1000),
(34,34,8, (convert(datetime,'2017-08-15 08:25:33', 120)), (convert(datetime,'2017-09-15 08:25:33', 120)),2000),
(35,35,8, (convert(datetime,'2015-05-17 17:18:51', 120)), (convert(datetime,'2015-06-17 17:18:51', 120)),5550),
(36,36,7, (convert(datetime,'2015-04-09 11:32:24', 120)), (convert(datetime,'2015-05-09 11:32:24', 120)),5555),
(37,37,6, (convert(datetime,'2015-12-17 00:52:01', 120)), (convert(datetime,'2016-01-17 00:52:01', 120)),5560),
(38,38,5, (convert(datetime,'2017-11-16 00:11:34', 120)), (convert(datetime,'2017-12-16 00:11:34', 120)),6650),
(39,39,4, (convert(datetime,'2016-07-18 19:54:22', 120)), (convert(datetime,'2016-08-18 19:54:22', 120)),5556),
(40,40,3, (convert(datetime,'2017-04-27 05:42:00', 120)), (convert(datetime,'2017-05-27 05:42:00', 120)),6665),
(1,41,2, (convert(datetime,'2015-12-04 13:35:39', 120)), (convert(datetime,'2015-12-30 13:35:39', 120)),1100),
(2,42,1, (convert(datetime,'2018-06-19 03:19:14', 120)), (convert(datetime,'2018-07-19 03:19:14', 120)),500),
(3,43,1, (convert(datetime,'2015-08-24 11:08:19', 120)), (convert(datetime,'2015-09-24 11:08:19', 120)),600),
(4,44,2, (convert(datetime,'2018-03-30 07:10:14', 120)), null,700),
(5,45,3, (convert(datetime,'2017-01-06 08:00:02', 120)), (convert(datetime,'2017-02-06 08:00:02', 120)),800),
(4,44,4, (convert(datetime,'2018-02-23 02:53:10', 120)), (convert(datetime,'2018-03-23 02:53:10', 120)),900),
(5,5,5, (convert(datetime,'2015-07-13 10:11:09', 120)), (convert(datetime,'2015-08-13 10:11:09', 120)),1000),
(6,6,6, (convert(datetime,'2016-09-03 11:35:43', 120)), (convert(datetime,'2016-10-03 11:35:43', 120)),1100),
(7,7,7, (convert(datetime,'2017-11-27 01:40:58', 120)), (convert(datetime,'2017-12-27 01:40:58', 120)),1200),
(8,8,8, (convert(datetime,'2018-07-07 19:01:25', 120)), null,1300)