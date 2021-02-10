//
//  ChuckNorrisUITests.swift
//  ChuckNorrisUITests
//
//  Created by Carolina Gomes on 08/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import XCTest

class ChuckNorrisUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testSelecionando_Uma_Categoria_Dev_E_Voltando() {
        let app = XCUIApplication()
        app.launch()
        //Seleciona um item na tableView
        let cell = app.tables.cells.staticTexts["dev"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        cell.tap()
        
        //Clica em voltar após 5 segundos
        let nav = app.navigationBars["dev"].buttons["Categories"]
        expectation(for: exists, evaluatedWith: nav, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        nav.tap()
    }
    
    func testSelecionando_Uma_Categoria_Food_E_Voltando() {
        let app = XCUIApplication()
        app.launch()
        //Seleciona um item na tableView
        let cell = app.tables.cells.staticTexts["food"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        cell.tap()
        
        //Clica em voltar após 5 segundos
        let nav = app.navigationBars["food"].buttons["Categories"]
        expectation(for: exists, evaluatedWith: nav, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        nav.tap()
    }
}
