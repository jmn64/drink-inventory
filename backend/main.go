package main

import (
	"database/sql"
	"errors"
	_ "github.com/glebarez/go-sqlite"
	"log"
	"os"
	"path/filepath"
)

const databasePath string = "./database"

func main() {
	println("Starting backend server...")
	database := openDB("test.db")
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

}

func openDB(filename string) *sql.DB {
	if _, err := os.Stat(databasePath); errors.Is(err, os.ErrNotExist) {
		err := os.Mkdir(databasePath, os.ModePerm)
		if err != nil {
			log.Println(err)
		}
	}
	db, err := sql.Open("sqlite", filepath.Join(databasePath, filename))
	if err != nil {
		log.Println(err)
	}
	return db
}
