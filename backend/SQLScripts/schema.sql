DROP TABLE IF EXISTS metadata;
CREATE TABLE metadata
(
    id INT NOT NULL,
    major_version INT NOT NULL,
    minor_version INT NOT NULL,
    patch_version INT NOT NULL,
    db_version INT NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS recipe;
CREATE TABLE recipe (
    id INT NOT NULL,
    name TEXT NOT NULL,
    rating INT,
    date_created TEXT,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS recipe_item;
CREATE TABLE recipe_item (
    id INT NOT NULL,
    recipe_tag INT NOT NULL,
    content INT NOT NULL,
    container INT,
    FOREIGN KEY (recipe_tag) REFERENCES recipe(id),
    FOREIGN KEY (content) REFERENCES ingredient (id),
    FOREIGN KEY (container) REFERENCES container(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS inventory_item;
CREATE TABLE inventory_item (
    id INT NOT NULL,
    content INT NOT NULL,
    container INT NOT NULL,
    current_volume INT NOT NULL,
    unit_of_measure INT NOT NULL,
    FOREIGN KEY (content) REFERENCES ingredient (id),
    FOREIGN KEY (container) REFERENCES container(id),
    FOREIGN KEY (unit_of_measure) REFERENCES unit_of_measure(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ingredient;
CREATE TABLE ingredient (
    id INT NOT NULL,
    name TEXT NOT NULL,
    abv DECIMAL(4, 2),
    category INT NOT NULL,
    FOREIGN KEY (category) REFERENCES ingredient_category(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ingredient_category;
CREATE TABLE ingredient_category (
    id INT NOT NULL,
    name TEXT NOT NULL,
    parent_category INT,
    FOREIGN KEY (parent_category) REFERENCES ingredient_category(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS unit_of_measure;
CREATE TABLE unit_of_measure (
    id INT NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS container;
CREATE TABLE container (
    id INT NOT NULL,
    name TEXT NOT NULL,
    volume INT NOT NULL,
    unit_of_measure INT NOT NULL,
    FOREIGN KEY (unit_of_measure) REFERENCES unit_of_measure(id),
    PRIMARY KEY (id)
)