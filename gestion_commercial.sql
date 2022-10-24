-- Active: 1666331421050@@127.0.0.1@3306@gestion_commercial

-- Les liens sites web j'ai utilise pour comprendre quelque champs dans cette base de donnes :

-- 1.raison sociale: https://wecount.ma/fr/raison-sociale-maroc

-- Pour Creation et inseration de base de donne "ALL-DATA.sql"

-- Pour vue qui je prend tous data "Ruby-Champs-Formula.txt"

-- Ex 01:

SELECT * FROM clients;

-- Ex 02:

SELECT * FROM produits;

-- Ex 03:

SELECT NumClient,VilleClient FROM clients;

-- Ex 04:

SELECT NumClient,RaisonSocial,Telephone FROM clients;

-- Ex 05:

SELECT * FROM clients WHERE NumClient=5;

-- Ex 06:

SELECT * FROM clients ORDER BY RaisonSocial DESC;

-- Ex 07:

SELECT * FROM clients ORDER BY RaisonSocial DESC ,VilleClient ASC;

-- Ex 08:

SELECT * FROM clients WHERE RaisonSocial LIKE "S%";

-- Ex 09:

SELECT * FROM clients WHERE RaisonSocial LIKE "%E";

-- Ex 10:

SELECT * FROM clients WHERE RaisonSocial LIKE "A%E";

-- Ex 11:

SELECT *
FROM clients
WHERE
    RaisonSocial LIKE "A%"
    AND RaisonSocial LIKE "%E";

-- Ex 12:

SELECT *
FROM clients
WHERE
    RaisonSocial LIKE "A%"
    OR RaisonSocial LIKE "%E";

-- Ex 13:

SELECT *
FROM clients
where
    VilleClient IN(
        "Casablanca",
        "Rabat",
        "Ouarzazate"
    );

-- Ex 14:

SELECT * FROM produits WHERE PrixUnitaire=300;

--Ex 15:

SELECT * FROM produits WHERE PrixUnitaire<300;

--Ex 16:

SELECT * FROM produits WHERE PrixUnitaire BETWEEN 300 AND 5000;

--Ex 17:

SELECT * FROM produits WHERE Disponible="Oui";

--Ex 18:

SELECT * FROM produits WHERE PrixUnitaire>300 AND Disponible = "Non";

--Ex 19:

SELECT * FROM commandes WHERE DateCommande="2016-01-11";

--Ex 20:

SELECT * FROM commandes WHERE DateCommande<"2016-01-11";

--Ex 21:

SELECT *
FROM commandes
WHERE
    DateCommande BETWEEN "2016-02-01" AND "2016-03-31";

--Ex 22:

SELECT * FROM commandes WHERE year(DateCommande)=year(NOW());

--Ex 23:

SELECT * FROM commandes WHERE month(DateCommande)="07";

--Ex 24:

SELECT
    NomProduit,
    CONCAT(
        TRUNCATE(PrixUnitaire * QteStockee, 2),
        " DH"
    ) as "valeur de stock"
FROM produits;

--Ex 25:

SELECT
    NomProduit,
    CONCAT(
        TRUNCATE(
            PrixUnitaire + (PrixUnitaire * 0.2),
            2
        ),
        " DH"
    ) as "TTC"
FROM produits;

--Ex 26:

SELECT DISTINCT VilleClient as "Les villes" FROM clients;

--Ex 27:

SELECT
    c.NumClient,
    RaisonSocial
FROM clients c
    INNER JOIN commandes cd ON c.NumClient = cd.NumClient;

--Ex 28:

SELECT
    DISTINCT p.RefProduit,
    p.NomProduit
FROM produits p
    INNER JOIN detailscommande dc ON p.RefProduit = dc.RefProduit;

--Ex 29:

SELECT
    p.RefProduit,
    p.NomProduit
FROM produits p
    INNER JOIN detailscommande dc ON p.RefProduit = dc.RefProduit
    INNER JOIN commandes cd ON dc.NumCommande = cd.NumCommande
    INNER JOIN clients c ON c.NumClient = cd.NumClient
WHERE c.NumClient = 15;

--Ex 30:

SELECT
    p.RefProduit,
    p.NomProduit
FROM produits p
    INNER JOIN detailscommande dc ON dc.RefProduit = p.RefProduit
    INNER JOIN commandes cd on cd.NumCommande = dc.NumCommande
WHERE cd.NumCommande = 5;

--Ex 31:

SELECT
    p.RefProduit,
    p.NomProduit
FROM produits p
    INNER JOIN detailscommande dc ON dc.RefProduit = p.RefProduit
    INNER JOIN commandes cd on cd.NumCommande = dc.NumCommande
WHERE
    cd.DateCommande = "2020-09-19";

--Ex 32:

SELECT
    p.RefProduit,
    p.NomProduit
FROM produits p
    INNER JOIN detailscommande dc ON dc.RefProduit = p.RefProduit
    INNER JOIN commandes cd on cd.NumCommande = dc.NumCommande
    INNER JOIN clients c ON cd.NumClient = c.NumClient
WHERE VilleClient = "Madrid";

--Ex 33:

SELECT
    p.RefProduit,
    p.NomProduit
FROM produits p
    INNER JOIN detailscommande dc ON dc.RefProduit = p.RefProduit
    INNER JOIN commandes cd on cd.NumCommande = dc.NumCommande
    INNER JOIN clients c ON cd.NumClient = c.NumClient
WHERE c.NumClient = 15;

--Ex 34:

SELECT COUNT(*) as "Nombre des clients" FROM clients;

--Ex 35:

SELECT
    COUNT(*) as "Nombre des clients habitant Berlin"
FROM clients
WHERE VilleClient = "Berlin";

--Ex 36:

SELECT
    COUNT(*) as "Nombre des produit disponible" ROM produits
WHERE Disponible = "Oui";

--Ex 37:

SELECT
    COUNT(*) as "Nombre des produit indisponible"
FROM produits
WHERE Disponible = "Non";

--Ex 38:

SELECT MAX(PrixUnitaire) as "Le plus grand prix" FROM produits;

--Ex 39:

SELECT MIN(PrixUnitaire) as "Le plus petit prix" FROM produits;

--Ex 40:

SELECT AVG(PrixUnitaire) as "La moyenne prix" FROM produits;

--Ex 41:

SELECT
    SUM(PrixUnitaire) as "La somme de tous les prix"
FROM produits;

--Ex 42:

SELECT
    COUNT(*) as "Le nombre de commandes de client numero 4"
FROM commandes
WHERE NumClient = 4;

--EX 43:

SELECT
    c.*,
    COUNT(c.NumCommande) as "Nombre de commandes"
FROM clients c
    INNER JOIN commandes cd ON c.NumClient = cd.NumClient
GROUP BY c.NumClient
HAVING
    COUNT(cd.NumCommande) > 2;

--EX 44:

SELECT
    c.RaisonSocial,
    COUNT(p.RefProduit) AS `Nombre  des produit`
FROM produits p
    INNER JOIN detailscommande dc ON p.RefProduit = dc.RefProduit
    INNER JOIN commandes cd ON cd.NumCommande = dc.NumCommande
    INNER JOIN clients c ON cd.NumClient = c.NumClient
GROUP BY c.RaisonSocial;

--EX 45:

SELECT c.*
FROM clients c
    LEFT JOIN commandes cd ON c.NumClient = cd.NumClient
WHERE cd.NumClient IS NULL;

--EX 46:

SELECT p.*
FROM produits p
    LEFT JOIN detailscommande dc ON p.RefProduit = dc.RefProduit
WHERE dc.RefProduit IS NULL;

--EX 47:

SELECT QteStockee FROM produits p;

--EX 48:

SELECT
    cd.NumCommande,
    SUM(p.PrixUnitaire) as `Montant total`
FROM commande cd
    JOIN detailscommande dc ON cd.NumCommande = dc.NumCommande
    JOIN produits p ON dc.RefProduit = p.RefProduit
GROUP BY cd.NumCommande
HAVING SUM(p.prixUnitaire);

--EX 49:

DELIMITER $$

CREATE FUNCTION STOCKSTATU(STOCK INT) RETURNS VARCHAR
(50) BEGIN 
	DECLARE message VARCHAR(30);
	IF stock < 10 THEN SET message = 'Besoin en réapprovisionnement';
	ELSE SET message = 'quantité Suffisante';
	END IF;
	RETURN message;
	END 
$ 

$ 

DELIMITER ;

SELECT StockStatu(QteStockee) as `Message` FROM produits;

--EX50:

SELECT cd.*
FROM commandes cd
    INNER JOIN clients c ON cd.NumClient = c.NumClient
WHERE c.VilleClient = "Madrid";

--EX 51:

SELECT cd.*, c.Villeclient
FROM commandes cd
    INNER JOIN clients c ON cd.NumClient = c.NumClient;

--EX 52:

SELECT
    c.VilleClient,
    cd.VilleLivraison
FROM clients c
    INNER JOIN commandes cd ON c.NumClient = cd.NumClient;

--EX 53:

SELECT c.Villeclient, c.AdresseClient FROM clients c 