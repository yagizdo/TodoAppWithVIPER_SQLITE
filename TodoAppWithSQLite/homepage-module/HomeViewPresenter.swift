//
//  HomeViewPresent.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 2.02.2023.
//

import Foundation

class HomeViewPresenter : ViewToPresenterHomeViewProtocol {
    var interactor: PresenterToInteractorHomeViewProtocol?
    var view: PresenterToViewHomeViewProtocol?
    
    func getCategories() {
        interactor?.getCategories()
    }
    
    func getTodos(categoryID: Int) {
        interactor?.getTodos(categoryID: categoryID)
    }
    
    func addCategory(categoryName: String) {
        interactor?.addCategory(categoryName: categoryName)
    }
    
    func deleteCategory(categoryID: Int) {
        interactor?.deleteCategory(categoryID: categoryID)
    }
    
    func deleteTodo(todoID: Int,categoryID:Int) {
        interactor?.deleteTodo(todoID: todoID,categoryID: categoryID)
    }
    
    func searchTodo(searchText: String) {
        interactor?.searchTodo(searchText: searchText)
    }
    
    func getTasksCount(categoryID: Int) -> Int {
        interactor!.getTasksCount(categoryID: categoryID)
    }
}

extension HomeViewPresenter : InteractorToPresenterHomeViewProtocol {
    func sendDataToPresenter(todos: [Todo]) {
        view?.sendDataToView(todos: todos)
    }
    
    func sendDataToPresenter(categories: [Category]) {
        view?.sendDataToView(categories: categories)
    }
}
