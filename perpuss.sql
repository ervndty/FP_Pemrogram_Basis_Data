-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Jul 2024 pada 05.29
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpuss`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_books` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_books_by_author_and_year` (IN `author_id` INT, IN `pub_year` INT)   BEGIN
    IF author_id IS NOT NULL AND pub_year IS NOT NULL THEN
        SELECT * FROM buku WHERE penulis_id = author_id AND tahun_terbit = pub_year;
    ELSE
        SELECT 'Invalid input parameters';
    END IF;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_books_by_author_and_year` (`author_id` INT, `pub_year` INT) RETURNS INT(11)  BEGIN
    DECLARE book_count INT;
    SELECT COUNT(*) INTO book_count FROM buku WHERE penulis_id = author_id AND tahun_terbit = pub_year;
    RETURN book_count;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_total_books` () RETURNS INT(11)  BEGIN
    DECLARE total_books INT;
    SELECT COUNT(*) INTO total_books FROM buku;
    RETURN total_books;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `base_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `base_view` (
`buku_id` int(11)
,`judul` varchar(100)
,`penulis_id` int(11)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `book_log`
--

CREATE TABLE `book_log` (
  `log_id` int(11) NOT NULL,
  `buku_id` int(11) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `aksi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `book_log`
--

INSERT INTO `book_log` (`log_id`, `buku_id`, `action`, `aksi`) VALUES
(1, 1, 'BEFORE UPDATE', NULL),
(2, 1, 'AFTER UPDATE', NULL),
(3, 6, 'BEFORE INSERT', NULL),
(4, 6, 'AFTER INSERT', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `buku_id` int(11) NOT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `penulis_id` int(11) DEFAULT NULL,
  `kategori_id` int(11) DEFAULT NULL,
  `tahun_terbit` int(4) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`buku_id`, `judul`, `penulis_id`, `kategori_id`, `tahun_terbit`, `stok`) VALUES
(1, 'New Title', 1, 1, 2020, 5),
(2, '1984 ', 2, 2, 2019, 3),
(3, 'Pride and Prejudice', 3, 3, 2021, 4),
(4, 'The Great Gatsby', 4, 1, 2018, 2),
(5, 'Moby-Dick', 5, 2, 2022, 6),
(6, 'Another Book', 1, 1, 2020, 5);

--
-- Trigger `buku`
--
DELIMITER $$
CREATE TRIGGER `after_delete_buku` AFTER DELETE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO book_log (buku_id, action) VALUES (OLD.buku_id, 'AFTER DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_buku` AFTER INSERT ON `buku` FOR EACH ROW BEGIN
    INSERT INTO book_log (buku_id, action) VALUES (NEW.buku_id, 'AFTER INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_buku` AFTER UPDATE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO book_log (buku_id, action) VALUES (NEW.buku_id, 'AFTER UPDATE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_buku` BEFORE DELETE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO book_log (buku_id, action) VALUES (OLD.buku_id, 'BEFORE DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_buku` BEFORE INSERT ON `buku` FOR EACH ROW BEGIN
    INSERT INTO book_log (buku_id, action) VALUES (NEW.buku_id, 'BEFORE INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_buku` BEFORE UPDATE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO book_log (buku_id, action) VALUES (NEW.buku_id, 'BEFORE UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `horizontal_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `horizontal_view` (
`buku_id` int(11)
,`judul` varchar(100)
,`penulis_id` int(11)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `kategori_id` int(11) NOT NULL,
  `nama_kategori` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`kategori_id`, `nama_kategori`) VALUES
(1, 'Sastra Klasik'),
(2, 'Fiksi Ilmiah'),
(3, 'Roman'),
(4, 'Fiksi Amerika'),
(5, 'Petualangan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `member`
--

CREATE TABLE `member` (
  `member_id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `no_tlp` int(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `member`
--

INSERT INTO `member` (`member_id`, `nama`, `alamat`, `no_tlp`, `email`) VALUES
(1, 'Daffa', 'Jl. Merdeka 10', 2147483647, 'daffa@mail.com'),
(2, 'Ervin', 'Jl. Merdeka 20', 2147483647, 'ervinb@mail.com'),
(3, 'Farel', 'Jl. Merdeka 30', 2147483647, 'farel@mail.com'),
(4, 'Ochim', 'Jl. Merdeka 40', 2147483647, 'ochim@mail.com'),
(5, 'Samsul', 'Jl. Merdeka 50', 2147483647, 'samsul@mail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjam`
--

CREATE TABLE `peminjam` (
  `peminjam_id` int(11) NOT NULL,
  `buku_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `tgl_pinjam` date DEFAULT NULL,
  `tgl_kembali` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjam`
--

INSERT INTO `peminjam` (`peminjam_id`, `buku_id`, `member_id`, `tgl_pinjam`, `tgl_kembali`) VALUES
(1, 1, 1, '2024-07-01', '2024-07-15'),
(2, 2, 2, '2024-07-02', '2024-07-16'),
(3, 3, 3, '2024-07-03', '2024-07-17'),
(4, 4, 4, '2024-07-04', '2024-07-18'),
(5, 5, 5, '2024-07-05', '2024-07-19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penerbit`
--

CREATE TABLE `penerbit` (
  `penerbit_id` int(11) NOT NULL,
  `since` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penulis`
--

CREATE TABLE `penulis` (
  `penulis_id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `negara` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penulis`
--

INSERT INTO `penulis` (`penulis_id`, `nama`, `negara`) VALUES
(1, ' Harper Lee', 'USA'),
(2, 'George Orwell', 'UK'),
(3, 'Jane Austen', 'UK'),
(4, 'F. Scott Fitzgerald', 'USA'),
(5, 'Herman Melville', 'USA');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vertical_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vertical_view` (
`buku_id` int(11)
,`judul` varchar(100)
,`penulis_id` int(11)
,`kategori_id` int(11)
,`tahun_terbit` int(4)
,`stok` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_inside_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_inside_view` (
`buku_id` int(11)
,`judul` varchar(100)
,`penulis_id` int(11)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `base_view`
--
DROP TABLE IF EXISTS `base_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `base_view`  AS SELECT `buku`.`buku_id` AS `buku_id`, `buku`.`judul` AS `judul`, `buku`.`penulis_id` AS `penulis_id` FROM `buku` WHERE `buku`.`tahun_terbit` = 2020 ;

-- --------------------------------------------------------

--
-- Struktur untuk view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS SELECT `buku`.`buku_id` AS `buku_id`, `buku`.`judul` AS `judul`, `buku`.`penulis_id` AS `penulis_id` FROM `buku` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vertical_view`
--
DROP TABLE IF EXISTS `vertical_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_view`  AS SELECT `buku`.`buku_id` AS `buku_id`, `buku`.`judul` AS `judul`, `buku`.`penulis_id` AS `penulis_id`, `buku`.`kategori_id` AS `kategori_id`, `buku`.`tahun_terbit` AS `tahun_terbit`, `buku`.`stok` AS `stok` FROM `buku` WHERE `buku`.`tahun_terbit` = 2020 ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_inside_view`
--
DROP TABLE IF EXISTS `view_inside_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_inside_view`  AS SELECT `base_view`.`buku_id` AS `buku_id`, `base_view`.`judul` AS `judul`, `base_view`.`penulis_id` AS `penulis_id` FROM `base_view`WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `book_log`
--
ALTER TABLE `book_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`buku_id`),
  ADD KEY `penulis_id` (`penulis_id`),
  ADD KEY `idx_kategori_penulis` (`kategori_id`,`penulis_id`),
  ADD KEY `idx_tahun_kategori` (`tahun_terbit`,`kategori_id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`kategori_id`);

--
-- Indeks untuk tabel `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`member_id`);

--
-- Indeks untuk tabel `peminjam`
--
ALTER TABLE `peminjam`
  ADD PRIMARY KEY (`peminjam_id`),
  ADD KEY `buku_id` (`buku_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indeks untuk tabel `penerbit`
--
ALTER TABLE `penerbit`
  ADD PRIMARY KEY (`penerbit_id`),
  ADD KEY `penerbit_id` (`penerbit_id`);

--
-- Indeks untuk tabel `penulis`
--
ALTER TABLE `penulis`
  ADD PRIMARY KEY (`penulis_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `book_log`
--
ALTER TABLE `book_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`penulis_id`) REFERENCES `penulis` (`penulis_id`),
  ADD CONSTRAINT `buku_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`);

--
-- Ketidakleluasaan untuk tabel `peminjam`
--
ALTER TABLE `peminjam`
  ADD CONSTRAINT `peminjam_ibfk_1` FOREIGN KEY (`buku_id`) REFERENCES `buku` (`buku_id`),
  ADD CONSTRAINT `peminjam_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
