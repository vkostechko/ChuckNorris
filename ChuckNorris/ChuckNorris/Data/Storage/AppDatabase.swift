//
//  AppDatabase.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/5/23.
//

import Foundation
import GRDB

struct AppDatabase {
    func openDatabase() throws -> DatabaseQueue {
        let fileManager = FileManager.default
        let databaseURL = try fileManager.url(for: .applicationSupportDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: nil,
                                              create: true)
            .appendingPathComponent("ChuckNorris.sqlite")

        // handle first database error to allow recovery
        do {
            // normal return
            return try doOpenDatabase(url: databaseURL)
        } catch {
            print("AppDatabase.doOpenDatabase error: \(error)")
        }

        // can't open database, try to recover
        // delete corrupted db file
        try fileManager.removeItem(at: databaseURL)

        print("AppDatabase.openDatabase: Database deleted!")

        // make another attempt to open database, if it fails, throw error
        return try doOpenDatabase(url: databaseURL)
    }

    /// Creates a fully initialized database with db.sqlite name
    /// and starts migrations
    private func doOpenDatabase(url: URL) throws -> DatabaseQueue {
        // Connect to the database
        // See https://github.com/groue/GRDB.swift/#database-connections
        let dbQueue = try DatabaseQueue(path: url.path)

        // Use DatabaseMigrator to define the database schema
        // See https://github.com/groue/GRDB.swift/#migrations
        try migrator.migrate(dbQueue)
        try dbQueue.vacuum()

        return dbQueue
    }

    /// The DatabaseMigrator that defines the database schema.
    ///
    /// This migrator is exposed so that migrations can be tested.
    // See https://github.com/groue/GRDB.swift/#migrations
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        migrator.eraseDatabaseOnSchemaChange = false

        migrator.registerMigration("1.0.0") { db in
            try db.create(table: JokeItemRecord.databaseTableName) { t in
                t.column(JokeItemRecord.Columns.id.name, .text).notNull().primaryKey()
                t.column(JokeItemRecord.Columns.categories.name, .text).notNull()
                t.column(JokeItemRecord.Columns.value.name, .text).notNull()
                t.column(JokeItemRecord.Columns.iconURL.name, .text)
                t.column(JokeItemRecord.Columns.url.name, .text)
                t.column(JokeItemRecord.Columns.creationDate.name, .text)
                t.column(JokeItemRecord.Columns.updateDate.name, .text)
            }
        }

        return migrator
    }
}
