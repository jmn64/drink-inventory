-- name: ListIngredients :many
SELECT * FROM ingredient
ORDER BY name;

-- name: GetIngredient :one
SELECT * FROM ingredient
WHERE id = ? LIMIT 1;

-- name: CreateIngredient :one
INSERT INTO ingredient (name, abv, category)
VALUES (?, ?, ?)
RETURNING id;

-- name: ListContainers :many
SELECT * FROM container
ORDER BY name;

-- name: GetContainer :one
SELECT * FROM container
WHERE id = ? LIMIT 1;

-- name: CreateContainer :one
INSERT INTO container (name, volume, unit_of_measure)
VALUES (?, ?, ?)
RETURNING id;

-- name: ListIngredientCategories :many
SELECT * FROM ingredient_category
ORDER BY name;

-- name: GetIngredientCategory :one
SELECT * FROM ingredient_category
WHERE id = ? LIMIT 1;

-- name: CreateIngredientCategory :one
INSERT INTO ingredient_category (name, parent_category)
VALUES (?, ?)
RETURNING id;

-- name: ListRecipes :many
SELECT * FROM recipe
ORDER BY name;

-- name: GetRecipe :one
SELECT * FROM recipe
WHERE id = ? LIMIT 1;

-- name: CreateRecipe :one
INSERT INTO recipe (name, rating, date_created)
VALUES (?, ?, ?)
RETURNING id;

-- name: RateRecipe :exec
UPDATE recipe
SET rating = ?
WHERE id = ?;

-- name: ListRecipeItems :many
SELECT * FROM recipe_item
ORDER BY recipe_tag;

-- name: GetRecipeItem :one
SELECT * FROM recipe_item
WHERE id = ? LIMIT 1;

-- name: CreateRecipeItem :one
INSERT INTO recipe_item (recipe_tag, content, container)
VALUES (?, ?, ?)
RETURNING id;

-- name: ListUnitsOfMeasure :many
SELECT * FROM unit_of_measure
ORDER BY name;

-- name: GetUnitOfMeasure :one
SELECT * FROM unit_of_measure
WHERE id = ? LIMIT 1;

-- name: CreateUnitOfMeasure :one
INSERT INTO unit_of_measure (name)
VALUES (?)
RETURNING id;

-- name: GetProgramVersion :one
SELECT major_version, minor_version, patch_version, db_version FROM metadata
WHERE id = 2 LIMIT 1;

-- name: ClearProgramVersion :exec
DELETE FROM metadata WHERE id = 2;

-- name: SetProgramVersion :exec
INSERT INTO metadata (id, major_version, minor_version, patch_version, db_version)
VALUES (
        ?, ?, ?, ?, ?
        );