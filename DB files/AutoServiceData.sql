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
INSERT INTO Client(name, surname, patronymic, birth_year, phone_number) VALUES
('Цуцкиха', 'Валентина', 'Юлиевна', 1965, 78297759405),
('Дагина', 'Любовь', 'Леонидовна', 1979, 77798062300),
('Ивашкин', 'Владимир', 'Юриевич', 1988, 78508343408),
('Энгалычева', 'Евгения', 'Казимировна', 1994, 72979680491),
('Набережнева', 'Майя', 'Александровна', 1979, 77837244228),
('Клюев', 'Александр', 'Арсениевич', 1960, 72366607976),
('Крылова', 'Ангелина', 'Анатолиевна', 1963, 77226452338),
('Домаша', 'Жанна', 'Романовна', 1958, 73878408501),
('Агейкина', 'Анна', 'Николаевна', 1985, 76731758100),
('Енотова', 'Владислава', 'Александровна', 1979, 72188907649),
('Яров', 'Гаврила', 'Трофимович', 1985, 71837120517),
('Букова', 'Владислава', 'Виталиевна', 1998, 73041141724),
('Кодица', 'Элеонора', 'Елисеевна', 1992, 74981335852),
('Александрина', 'Татьяна', 'Федотовна', 1984, 79283728127),
('Третьяков', 'Чеслав', 'Евграфович', 1999, 72649765637),
('Рубцова', 'Анастасия', 'Карповна', 1989, 76022477311),
('Эзерин', 'Эрнст', 'Иванович', 1987, 77061825363),
('Огурцов', 'Денис', 'Остапович', 1969, 73946198993),
('Грефа', 'Ирина', 'Никитевна', 1977, 77766977819),
('Баландина', 'Мария', 'Казимировна', 1989, 71526928545),
('Симонов', 'Чеслав', 'Герасимович', 1981, 78081121024),
('Щепкин', 'Вениамин', 'Алексеевич', 1991, 72566936003),
('Попырин', 'Тимур', 'Георгиевич', 1968, 76644805771),
('Паршин', 'Евстигней', 'Чеславович', 1969, 72043795324),
('Шарапов', 'Виссарион', 'Феликсович', 1960, 71993077595),
('Корнеев', 'Терентий', 'Андроникович', 1987, 71291578191),
('Акулова', 'Марианна', 'Германовна', 1975, 71256864699),
('Янкилович', 'Василий', 'Моисеевич', 1973, 72881398587),
('Кривонос', 'Трофим', 'Архипович', 1966, 72156648867),
('Стегнов', 'Всеволод', 'Мечиславович', 1962, 78319298818),
('Нутрихин', 'Чеслав', 'Потапович', 1979, 75138326212),
('Худовекова', 'Вероника', 'Станиславовна', 1989, 76454787410),
('Капп', 'Филипп', 'Давыдович', 1968, 76435694447),
('Ахвледиани', 'Алиса', 'Никитевна', 1995, 78336617355),
('Ямлиханов', 'Емельян', 'Архипович', 1961, 78684063904),
('Китаев', 'Семён', 'Валериевич', 1994, 77398139634),
('Якимова', 'Евдокия', 'Федотовна', 1977, 71718548207),
('Брагин', 'Матвей', 'Матвеевич', 1964, 75666175215),
('Бойкова', 'Марфа', 'Антониновна', 1989, 75532124492),
('Рокоссовский', 'Серафим', 'Саввевич', 1971, 78291868294)
GO
INSERT INTO Car(model_id, manufacturing_year, transmission_id, engine_power, owner_id) VALUES
((SELECT id FROM Model WHERE name = 'A1'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 122, 1),
((SELECT id FROM Model WHERE name = 'A2'), 2007, (SELECT id FROM Transmission WHERE name = 'Механическая'), 115, 2),
((SELECT id FROM Model WHERE name = 'A3'), 2015, (SELECT id FROM Transmission WHERE name = 'Механическая'), 150, 3),
((SELECT id FROM Model WHERE name = 'A4'), 1995, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 125, 4),
((SELECT id FROM Model WHERE name = 'A5'), 2014, (SELECT id FROM Transmission WHERE name = 'Вариатор'), 204, 5),
((SELECT id FROM Model WHERE name = 'A6'), 1994, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 90, 6),
((SELECT id FROM Model WHERE name = 'A7'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 204, 7),
((SELECT id FROM Model WHERE name = 'A8'), 1998, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 150, 8),
((SELECT id FROM Model WHERE name = 'i3'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 9),
((SELECT id FROM Model WHERE name = 'i8'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 10),
((SELECT id FROM Model WHERE name = 'X1'), 2012, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 11),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 177, 12),
((SELECT id FROM Model WHERE name = 'X4'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 190, 13),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 450, 14),
((SELECT id FROM Model WHERE name = 'X6'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 258, 15),
((SELECT id FROM Model WHERE name = 'A1'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 140, 16),
((SELECT id FROM Model WHERE name = 'A2'), 2006, (SELECT id FROM Transmission WHERE name = 'Механическая'), 115, 17),
((SELECT id FROM Model WHERE name = 'A3'), 1996, (SELECT id FROM Transmission WHERE name = 'Механическая'), 101, 18),
((SELECT id FROM Model WHERE name = 'A4'), 2001, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 180, 19),
((SELECT id FROM Model WHERE name = 'A5'), 2011, (SELECT id FROM Transmission WHERE name = 'Вариатор'), 190, 20),
((SELECT id FROM Model WHERE name = 'A6'), 2018, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 218, 21),
((SELECT id FROM Model WHERE name = 'A7'), 2012, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 310, 22),
((SELECT id FROM Model WHERE name = 'A8'), 1994, (SELECT id FROM Transmission WHERE name = 'Механическая'), 174, 23),
((SELECT id FROM Model WHERE name = 'i3'), 2013, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 24),
((SELECT id FROM Model WHERE name = 'i8'), 2016, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 25),
((SELECT id FROM Model WHERE name = 'X1'), 2013, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 26),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Механическая'), 143, 27),
((SELECT id FROM Model WHERE name = 'X4'), 2016, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 28),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 381, 29),
((SELECT id FROM Model WHERE name = 'X6'), 2008, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 235, 30),
((SELECT id FROM Model WHERE name = 'A1'), 2011, (SELECT id FROM Transmission WHERE name = 'Механическая'), 90, 31),
((SELECT id FROM Model WHERE name = 'A2'), 2006, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 61, 32),
((SELECT id FROM Model WHERE name = 'A3'), 1996, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 125, 33),
((SELECT id FROM Model WHERE name = 'A4'), 2015, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 34),
((SELECT id FROM Model WHERE name = 'A5'), 2011, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 245, 35),
((SELECT id FROM Model WHERE name = 'A6'), 2016, (SELECT id FROM Transmission WHERE name = 'Механическая'), 190, 36),
((SELECT id FROM Model WHERE name = 'A7'), 2018, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 333, 37),
((SELECT id FROM Model WHERE name = 'A8'), 2000, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 420, 38),
((SELECT id FROM Model WHERE name = 'i3'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 34, 39),
((SELECT id FROM Model WHERE name = 'i8'), 2016, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 231, 40),
((SELECT id FROM Model WHERE name = 'X1'), 2012, (SELECT id FROM Transmission WHERE name = 'Механическая'), 245, 1),
((SELECT id FROM Model WHERE name = 'X3'), 2010, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 177, 2),
((SELECT id FROM Model WHERE name = 'X4'), 2014, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 190, 3),
((SELECT id FROM Model WHERE name = 'X5'), 2017, (SELECT id FROM Transmission WHERE name = 'Автоматическая'), 450, 4),
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
(1,1,8, (convert(datetime,'2018-03-01 23:05:06', 120)), (convert(datetime,'2018-03-10 23:36:11', 120)),4762),
(2,2,6, (convert(datetime,'2015-09-12 23:26:54', 120)), (convert(datetime,'2016-02-15 21:22:45', 120)),9976),
(3,3,3, (convert(datetime,'2017-01-23 00:49:47', 120)), (convert(datetime,'2017-06-08 01:15:30', 120)),2360),
(4,4,3, (convert(datetime,'2015-12-03 02:10:16', 120)), (convert(datetime,'2016-05-17 19:15:58', 120)),6771),
(5,5,4, (convert(datetime,'2015-01-09 01:40:33', 120)), (convert(datetime,'2017-04-08 03:30:32', 120)),3733),
(6,6,6, (convert(datetime,'2016-10-22 23:40:56', 120)), (convert(datetime,'2017-02-15 11:15:49', 120)),8195),
(7,7,8, (convert(datetime,'2017-07-31 16:38:56', 120)), (convert(datetime,'2017-12-14 19:05:28', 120)),2526),
(8,8,7, (convert(datetime,'2015-08-02 07:19:36', 120)), (convert(datetime,'2015-09-24 15:31:40', 120)),7360),
(9,9,7, (convert(datetime,'2016-01-05 00:44:08', 120)), (convert(datetime,'2018-07-31 02:31:05', 120)),4255),
(10,10,1, (convert(datetime,'2015-05-29 12:17:19', 120)), (convert(datetime,'2016-03-07 03:31:34', 120)),2442),
(11,11,1, (convert(datetime,'2017-01-25 19:51:06', 120)), (convert(datetime,'2018-04-06 21:30:36', 120)),5190),
(12,12,7, (convert(datetime,'2014-11-23 06:51:29', 120)), (convert(datetime,'2016-05-20 21:02:55', 120)),8643),
(13,13,2, (convert(datetime,'2017-08-19 15:51:05', 120)), (convert(datetime,'2017-11-29 02:15:44', 120)),9657),
(14,14,6, (convert(datetime,'2018-01-24 13:50:08', 120)), (convert(datetime,'2018-03-28 12:07:15', 120)),7267),
(15,15,2, (convert(datetime,'2016-10-15 23:22:27', 120)), (convert(datetime,'2017-01-18 22:24:05', 120)),5605),
(16,16,1, (convert(datetime,'2014-04-18 16:27:58', 120)), (convert(datetime,'2014-10-03 14:09:37', 120)),6421),
(17,17,4, (convert(datetime,'2015-06-23 05:19:43', 120)), (convert(datetime,'2018-09-16 20:58:24', 120)),3424),
(18,18,8, (convert(datetime,'2017-08-16 05:32:10', 120)), (convert(datetime,'2017-08-21 13:01:54', 120)),814),
(19,19,6, (convert(datetime,'2016-05-15 23:03:06', 120)), (convert(datetime,'2016-11-08 00:52:46', 120)),9094),
(20,20,1, (convert(datetime,'2016-07-08 20:06:11', 120)), (convert(datetime,'2016-09-03 02:09:58', 120)),2921),
(21,21,3, (convert(datetime,'2015-04-02 06:49:03', 120)), (convert(datetime,'2015-05-30 04:46:39', 120)),9628),
(22,22,8, (convert(datetime,'2017-08-12 09:22:54', 120)), (convert(datetime,'2018-02-25 21:39:05', 120)),4512),
(23,23,5, (convert(datetime,'2015-02-24 11:20:53', 120)), (convert(datetime,'2015-07-31 01:56:40', 120)),6988),
(24,24,7, (convert(datetime,'2017-03-15 14:06:26', 120)), (convert(datetime,'2017-08-21 12:16:19', 120)),8134),
(25,25,7, (convert(datetime,'2016-01-22 12:29:50', 120)), (convert(datetime,'2016-07-21 19:12:02', 120)),4468),
(26,26,4, (convert(datetime,'2015-05-30 17:55:22', 120)), (convert(datetime,'2015-09-22 22:21:46', 120)),2949),
(27,27,3, (convert(datetime,'2016-10-25 22:45:42', 120)), (convert(datetime,'2017-06-01 12:23:17', 120)),7662),
(28,28,6, (convert(datetime,'2015-08-18 05:44:48', 120)), (convert(datetime,'2015-11-11 08:41:00', 120)),2850),
(29,29,8, (convert(datetime,'2015-07-02 23:22:15', 120)), (convert(datetime,'2015-08-31 09:27:52', 120)),3203),
(30,30,2, (convert(datetime,'2016-03-25 04:41:53', 120)), (convert(datetime,'2016-10-01 13:33:03', 120)),5080),
(31,31,7, (convert(datetime,'2015-07-16 00:23:20', 120)), (convert(datetime,'2015-10-09 11:39:26', 120)),9510),
(32,32,3, (convert(datetime,'2015-02-27 15:09:11', 120)), (convert(datetime,'2015-06-09 19:49:19', 120)),8434),
(33,33,3, (convert(datetime,'2017-11-02 17:14:19', 120)), (convert(datetime,'2017-11-16 21:53:45', 120)),7666),
(34,34,8, (convert(datetime,'2015-03-14 22:12:43', 120)), (convert(datetime,'2015-10-01 12:42:49', 120)),1603),
(35,35,6, (convert(datetime,'2017-09-11 07:50:36', 120)), (convert(datetime,'2017-09-25 12:40:09', 120)),6611),
(36,36,1, (convert(datetime,'2017-01-14 14:34:06', 120)), (convert(datetime,'2017-04-15 21:20:53', 120)),6328),
(37,37,2, (convert(datetime,'2018-01-27 17:01:44', 120)), (convert(datetime,'2018-03-29 03:12:26', 120)),9970),
(38,38,3, (convert(datetime,'2018-03-29 19:05:46', 120)), (convert(datetime,'2018-07-16 20:23:25', 120)),4328),
(39,39,7, (convert(datetime,'2017-07-31 00:05:29', 120)), (convert(datetime,'2017-11-07 04:01:43', 120)),772),
(40,40,1, (convert(datetime,'2017-08-28 17:09:50', 120)), (convert(datetime,'2017-08-30 01:23:57', 120)),711),
(1,41,7, (convert(datetime,'2018-04-10 22:00:52', 120)), (convert(datetime,'2018-04-19 06:52:31', 120)),7185),
(2,42,7, (convert(datetime,'2017-11-06 13:58:29', 120)), (convert(datetime,'2018-02-08 10:40:46', 120)),6521),
(3,43,2, (convert(datetime,'2016-05-24 19:50:46', 120)), (convert(datetime,'2017-05-03 15:01:06', 120)),7147),
(4,44,1, (convert(datetime,'2015-12-05 16:52:20', 120)), (convert(datetime,'2018-06-10 09:18:26', 120)),9168),
(5,45,6, (convert(datetime,'2017-08-23 19:17:41', 120)), (convert(datetime,'2017-09-15 17:30:04', 120)),3880),
(4,44,3, (convert(datetime,'2017-04-10 22:00:52', 120)), (convert(datetime,'2017-04-19 06:52:31', 120)),7185),
(5,5,2, (convert(datetime,'2018-11-06 13:58:29', 120)), (convert(datetime,'2019-02-08 10:40:46', 120)),6521),
(6,6,7, (convert(datetime,'2017-05-03 19:50:46', 120)), (convert(datetime,'2017-05-23 15:01:06', 120)),7147),
(7,7,8, (convert(datetime,'2017-12-05 16:52:20', 120)), (convert(datetime,'2018-01-10 09:18:26', 120)),9168),
(8,8,2, (convert(datetime,'2017-01-23 19:17:41', 120)), (convert(datetime,'2017-02-15 17:30:04', 120)),3880)