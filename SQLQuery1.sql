CREATE TABLE HOTEL(
	IdHotelu INT NOT NULL IDENTITY(1,1) primary key,
	NumerHotelu INT,
	Ulica varchar(60),
	NumerUlica varchar(60),
	Miasto varchar(60),
	KodPocztowy varchar(60),
	CzyJestRestauracja BIT
);


CREATE TABLE STANOWISKO(
	IdStanowiska INT NOT NULL IDENTITY(1,1) primary key,
	NazwaStanowiska Varchar(60),
	Pensja Decimal
);

CREATE TABLE PRACOWNIK(
	PESEL Varchar(11) NOT NULL primary key,
	Imie Varchar(60),
	Nazwisko Varchar(60),
	NumerTelefonu Varchar(60),
	UmowaOd DATETIME,
	UmowaDo DATETIME,
	IdHotelu INT,
	IdStanowiska INT,
	CONSTRAINT IdHotelu FOREIGN KEY (IdHotelu) REFERENCES HOTEL(IdHotelu),
	CONSTRAINT IdStanowiska FOREIGN KEY (IdStanowiska) REFERENCES STANOWISKO (IdStanowiska)
);

CREATE TABLE DYZUR(
	IdDyzuru INT NOT NULL IDENTITY(1,1) primary key,
	DyzurOd DATETIME,
	DyzurDo DATETIME,
	IdPracownika Varchar(11),
	CONSTRAINT IdPracownika FOREIGN KEY (IdPracownika) REFERENCES PRACOWNIK(PESEL)
);

CREATE TABLE RESTAURACJA(
	IdRestauracji INT NOT NULL IDENTITY(1,1) primary key,
	GodzinaOtwarcia Int,
	GodzinaZamkniecia Int,
	IdHotelu INT,
	CONSTRAINT IdHotelu2 FOREIGN KEY(IdHotelu) REFERENCES HOTEL(IdHotelu)
);

CREATE TABLE POTRAWA(
	IdPotrawy INT NOT NULL IDENTITY(1,1) primary key,
	IdRestauracji INT,
	CONSTRAINT IdRestauracji FOREIGN KEY(IdRestauracji) REFERENCES RESTAURACJA (IdRestauracji)
);

CREATE TABLE STATUS_KLIENTA(
	IdStatusu INT NOT NULL IDENTITY(1,1) primary key,
	NazwaStatusu Varchar(60),
	ZnizkaProcentowa INT,
	CzyWliczoneSniadania BIT
);

CREATE TABLE KATEGORIA_POKOJU(
	IdKategorii INT NOT NULL IDENTITY(1,1) primary key,
	CzyJestLazienka BIT,
	CzyJestBalkon BIT,
	NazwaKategorii Varchar(60),
	CzyJestLodowka BIT,
	DwuosoboweLozko BIT
);

CREATE TABLE POKOJ(
	IdPokoju INT NOT NULL IDENTITY(1,1) primary key,
	NumerPokoju INT,
	CzyZajety BIT,
	IdKategorii INT,
	CenaPokoju DECIMAL,
	IdHotelu INT,
	LiczbaOsob INT,
	LiczbaLozek INT,
	CONSTRAINT IdKategorii FOREIGN KEY (IdKategorii) REFERENCES KATEGORIA_POKOJU(IdKategorii),
	CONSTRAINT IdHotelu3 FOREIGN KEY (IdHotelu) REFERENCES HOTEL(IdHotelu)
);

CREATE TABLE KLIENT(
	IdKlienta INT NOT NULL IDENTITY(1,1) primary key,
	Imie Varchar(60),
	Nazwisko Varchar(60),
	NumerTelefonu Varchar(60),
	Ulica Varchar(60),
	NumerUlica Varchar(60),
	Miasto Varchar(60),
	KodPocztowy Varchar(60),
	IdStatusu INT,
	CONSTRAINT IdStatusu FOREIGN KEY (IdStatusu) REFERENCES STATUS_KLIENTA(IdStatusu)
);

CREATE TABLE REZERWACJA(
	IdRezerwacji INT NOT NULL IDENTITY(1,1) primary key,
	DataRezerwacji DATETIME,
	PoczatekPobytu DATETIME,
	KoniecPobytu DATETIME,
	IdKlienta INT,
	IdPokoju INT,
	IdHotelu INT,
	CONSTRAINT IdKlienta2 FOREIGN KEY (IdKlienta) REFERENCES KLIENT(IdKlienta),
	CONSTRAINT IdPokoju2 FOREIGN KEY (IdPokoju) REFERENCES POKOJ(IdPokoju),
	CONSTRAINT IdHotelu5 FOREIGN KEY (IdHotelu) REFERENCES HOTEL(IdHotelu)
);