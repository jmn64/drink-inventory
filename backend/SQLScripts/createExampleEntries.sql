INSERT INTO unitOfMeasure (name) VALUES ('milliliter');
INSERT INTO container (name, volume, unitOfMeasure)
VALUES (
        'Bottle',
        750,
        (SELECT id FROM unitOfMeasure WHERE name = 'milliliter')
        );
INSERT INTO container (name, volume, unitOfMeasure)
VALUES (
        'Shot Glass',
        44,
        (SELECT id FROM unitOfMeasure WHERE name = 'milliliter')
       );