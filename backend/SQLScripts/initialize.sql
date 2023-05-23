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
    dateCreated TEXT,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS recipeItem;
CREATE TABLE recipeItem (
    id INT NOT NULL,
    recipeTag INT NOT NULL,
    content INT NOT NULL,
    container INT,
    FOREIGN KEY (recipeTag) REFERENCES recipe(id),
    FOREIGN KEY (content) REFERENCES ingredient (id),
    FOREIGN KEY (container) REFERENCES container(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS inventoryItem;
CREATE TABLE inventoryItem (
    id INT NOT NULL,
    content INT NOT NULL,
    container INT NOT NULL,
    currentVolume INT NOT NULL,
    unitOfMeasure INT NOT NULL,
    FOREIGN KEY (content) REFERENCES ingredient (id),
    FOREIGN KEY (container) REFERENCES container(id),
    FOREIGN KEY (unitOfMeasure) REFERENCES unitOfMeasure(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ingredient;
CREATE TABLE ingredient (
    id INT NOT NULL,
    name TEXT NOT NULL,
    abv DECIMAL(4, 2),
    category INT NOT NULL,
    FOREIGN KEY (category) REFERENCES ingredientCategory(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ingredientCategory;
CREATE TABLE ingredientCategory (
    id INT NOT NULL,
    name TEXT NOT NULL,
    parentCategory INT,
    FOREIGN KEY (parentCategory) REFERENCES ingredientCategory(id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS unitOfMeasure;
CREATE TABLE unitOfMeasure (
    id INT NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS container;
CREATE TABLE container (
    id INT NOT NULL,
    name TEXT NOT NULL,
    volume INT NOT NULL,
    unitOfMeasure INT NOT NULL,
    FOREIGN KEY (unitOfMeasure) REFERENCES unitOfMeasure(id),
    PRIMARY KEY (id)
)