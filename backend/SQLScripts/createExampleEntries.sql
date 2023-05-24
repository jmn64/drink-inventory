INSERT INTO unit_of_measure (name) VALUES ('milliliter');
INSERT INTO container (name, volume, unitOfMeasure)
VALUES (
        'Bottle',
        750,
        (SELECT id FROM unit_of_measure WHERE name = 'milliliter')
        );
INSERT INTO container (name, volume, unitOfMeasure)
VALUES (
        'Shot Glass',
        44,
        (SELECT id FROM unit_of_measure WHERE name = 'milliliter')
       );

INSERT INTO ingredient_category (name) VALUES ('Whiskey');

INSERT INTO ingredient_category (name, parent_category)
VALUES (
        'Bourbon',
        (SELECT id FROM ingredient_category WHERE name = 'Whiskey')
       );

INSERT INTO ingredient_category (name, parent_category)
VALUES (
        'Rye',
        (SELECT id FROM ingredient_category WHERE name = 'Whiskey')
       );

INSERT INTO ingredient (name, abv, category)
VALUES (
        'Bulleit Bourbon',
        40.00,
        (SELECT id FROM ingredient_category WHERE name = 'Bourbon')
        );

INSERT INTO ingredient (name, abv, category)
VALUES (
        'Bulleit Rye',
        40.00,
        (SELECT id FROM ingredient_category WHERE name = 'Rye')
       );