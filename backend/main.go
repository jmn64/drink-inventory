package main

import (
	"backend/SQLScripts/sqlCode"
	"context"
	"database/sql"
	_ "embed"
	"errors"
	_ "github.com/glebarez/go-sqlite"
	"log"
	"os"
	"path/filepath"
)

const databasePath string = "./database"
const major_version = 0
const minor_version = 1
const patch_version = 0
const database_version = 1

//go:embed SQLScripts/schema.sql
var dd1 string

func main() {
	println("Starting backend server...")
	database, initialized := openDB("test.db")
	defer func(database *sql.DB) {
		err := database.Close()
		if err != nil {
			log.Println(err)
		}
	}(database)

	err := database.Ping()
	if err != nil {
		log.Fatal(err)
	}

	ctx := context.Background()
	if !initialized {
		err = createTables(database, ctx)
		if err != nil {
			log.Println(err)
		}
	}

	queries := sqlCode.New(database)
	if !initialized {
		err = queries.SetProgramVersion(ctx, sqlCode.SetProgramVersionParams{
			ID:           2,
			MajorVersion: major_version,
			MinorVersion: minor_version,
			PatchVersion: patch_version,
			DbVersion:    database_version,
		})
	} else {
		version, err := queries.GetProgramVersion(ctx)
		if err != nil {
			log.Println(err)
		}
		if version.DbVersion != database_version {
			err = database.Close()
			if err != nil {
				log.Println(err)
			}
			log.Fatal("incompatible database version: migrate to version: %i", database_version)
		}
		if version.MajorVersion != major_version || version.MinorVersion != minor_version {
			log.Println("This database was created with a different program version")
		}
	}
}

func openDB(filename string) (*sql.DB, bool) {
	if _, err := os.Stat(databasePath); errors.Is(err, os.ErrNotExist) {
		err := os.Mkdir(databasePath, os.ModePerm)
		if err != nil {
			log.Println(err)
		}
	}

	var dbInitialized bool
	if _, err := os.Stat(filepath.Join(databasePath, filename)); errors.Is(err, os.ErrNotExist) {
		dbInitialized = false
	} else {
		dbInitialized = true
	}

	db, err := sql.Open("sqlite", filepath.Join(databasePath, filename))
	if err != nil {
		log.Println(err)
	}
	return db, dbInitialized
}

func createTables(db *sql.DB, ctx context.Context) error {
	if _, err := db.ExecContext(ctx, dd1); err != nil {
		return err
	}
	return nil
}

func insertDefaultData(ctx context.Context, queries *sqlCode.Queries) {
	milliliter, err := queries.CreateUnitOfMeasure(ctx, "milliliter")
	if err != nil {
		log.Println(err)
	}
	drop, err := queries.CreateUnitOfMeasure(ctx, "drop")
	if err != nil {
		log.Println(err)
	}
	alcohol, err := queries.CreateIngredientCategory(ctx, sqlCode.CreateIngredientCategoryParams{
		Name: "Alcohol",
	})
	if err != nil {
		log.Println(err)
	}
	queries.CreateIngredientCategory(ctx, sqlCode.CreateIngredientCategoryParams{
		Name: "Vodka",
		ParentCategory: sql.NullInt64{
			Int64: alcohol,
			Valid: true,
		},
	})
	queries.CreateIngredientCategory(ctx, sqlCode.CreateIngredientCategoryParams{
		Name: "Whiskey",
		ParentCategory: sql.NullInt64{
			Int64: alcohol,
			Valid: true,
		},
	})
	queries.CreateIngredientCategory(ctx, sqlCode.CreateIngredientCategoryParams{
		Name: "Gin",
		ParentCategory: sql.NullInt64{
			Int64: alcohol,
			Valid: true,
		},
	})
}
