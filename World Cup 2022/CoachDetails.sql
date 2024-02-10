-- ENTERING COACH DETAILS

USE worldcup2022;

CREATE TABLE CoachDetails (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  country VARCHAR(75),
  nickname VARCHAR(75),
  fifa_rank INT,
  coach_name VARCHAR(75),
  coach_age INT,
  coach_nationality VARCHAR(755) 
  );
  
SELECT * FROM CoachDetails;

INSERT INTO CoachDetails
  (id,country,nickname,fifa_rank,coach_name,coach_age,coach_nationality)
VALUES
  (1,'Brazil','A Selecao',1,'Tito',61,'Brazil'),
  (2,'Costa Rica','Los Ticos',31,'Luis Fernando Suarez',62,'Colombia'),
  (3,'Japan','Samurai Blue',24,'Hajime Moriyasu',54,'Japan'),
  (4,'Denmark','Danish Dynamite',10,'Kasper Hjulmand',50,'Denmark'),
  (5,'Australia','Soccoroos',38,'Graham Arnold',59,'Australia'),
  (6,'Croatia','Vatreni',12,'Zlatko Dalic',56,'Croatia'),
  (7,'Switzerland','Rossocrociati',15,'Murat Yakin',48,'Switzerland'),
  (8,'France','Les Blues',4,'Didier Deschamps',54,'France'),
  (9,'USA','The Stars and Stripes',16,'Gregg Berhalter',49,'USA'),
  (10,'Wales','The Dragons',19,'Robert Page',48,'Wales'),
  (11,'Cameroon','Les Lions Indomptables',43,'Rigobert Song',46,'Cameroon'),
  (12,'Germany','Der Panzer',11,'Hansi Flick',57,'Germany'),
  (13,'Belgium','The Red Devils',2,'Roberto Martinez',49,'Spain'),
  (14,'Morocco','The Atlas Lions',22,'Walid Regragui',49,'France'),
  (15,'England','The Three Lions',5,'Gareth Southgate',52,'England'),
  (16,'Poland','Bialo-czerwani',26,'Czaslaw Michniewicz',52,'Poland'),
  (17,'Portugal','Os Navegadores',9,'Fernando Santos',68,'Portugal'),
  (18,'Uruguay','La Celeste',14,'Diego Alonso',47,'Uruguay'),
  (19,'Senegal','Lions of Teranga',18,'Aliou Cisse',46,'Senegal'),
  (20,'Neterland','Oranje',8,'Louis Van Gaal',71,'Neterland'),
  (21,'Spain','La Furia Roja',7,'Luis Enrique',52,'Spain'),
  (22,'Serbia','Orlovi',21,'Dragan Stojkovic',57,'Serbia'),
  (23,'Argentina','La Albiceleste',3,'Lionel Scaloni',44,'Argentina'),
  (24,'Saudi Arabia','The Green Falcon',51,'Harve Renard',54,'France'),
  (25,'Qatar','The Maroon',50,'Felix Sanchez',46,'Spain'),
  (26,'South Korea','Taeguk Warriors',28,'Paulo Bento',53,'Portugal'),
  (27,'Iran','Team Melli',20,'Carlos Queiroz',69,'Portugal'),
  (28,'Tunisia','Eagles of Carthage',30,'Jalel Kadri',52,'Tunisia'),
  (29,'Canada','The Maple Leafs',41,'John Herdman',47,'England'),
  (30,'Mexico','El Tri',13,'Gerardo Martino',59,'Argentina'),
  (31,'Ghana','Black Start',61,'Otto Addo',47,'Ghana'),
  (32,'Ecuador','La Tri',44,'Gustavo Alfaro',60,'Argentina');