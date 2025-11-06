-- Tworzenie bazy danych
CREATE DATABASE IF NOT EXISTS biblioteka CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;
USE biblioteka;

-- Tabela: Autorzy
CREATE TABLE autorzy (
    autor_id INT AUTO_INCREMENT PRIMARY KEY,
    autor_name VARCHAR(100) NOT NULL,
    autor_surname VARCHAR(100) NOT NULL,
    autor_nationality VARCHAR(100)
);

-- Tabela: Kategorie
CREATE TABLE kategoria (
    kategoria_id INT AUTO_INCREMENT PRIMARY KEY,
    kategoria_name VARCHAR(100) NOT NULL
);

-- Tabela: Użytkownicy
CREATE TABLE uzytkownicy (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_surname VARCHAR(100) NOT NULL
);

-- Tabela: Książki
CREATE TABLE ksiazki (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tytul VARCHAR(200) NOT NULL,
    autor_id INT NOT NULL,
    rok_wydania INT,
    kategoria_id INT,
    dostepnosc BOOLEAN DEFAULT TRUE,
    oceny VARCHAR(255),
    FOREIGN KEY (autor_id) REFERENCES autorzy(autor_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (kategoria_id) REFERENCES kategoria(kategoria_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela: Wypożyczenia
CREATE TABLE wypozyczenia (
    wypozyczenia_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ksiazka_id INT NOT NULL,
    data_wypozyczenia DATE NOT NULL,
    data_zwrotu DATE,
    FOREIGN KEY (user_id) REFERENCES uzytkownicy(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ksiazka_id) REFERENCES ksiazki(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela: Ocena
CREATE TABLE ocena (
    user_ocena_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ksiazka_id INT NOT NULL,
    oceny VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES uzytkownicy(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ksiazka_id) REFERENCES ksiazki(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Przykładowe dane
INSERT INTO autorzy (autor_name, autor_surname, autor_nationality)
VALUES ('Adam', 'Mickiewicz', 'Polska'),
       ('Henryk', 'Sienkiewicz', 'Polska');

INSERT INTO kategoria (kategoria_name)
VALUES ('Powieść'), ('Poezja'), ('Dramat');

INSERT INTO uzytkownicy (user_name, user_surname)
VALUES ('Jan', 'Kowalski'), ('Anna', 'Nowak');

INSERT INTO ksiazki (tytul, autor_id, rok_wydania, kategoria_id, dostepnosc)
VALUES ('Pan Tadeusz', 1, 1834, 2, TRUE),
       ('Quo Vadis', 2, 1896, 1, TRUE);