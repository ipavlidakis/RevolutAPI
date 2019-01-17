//
//  AppDelegate.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    private var store: StoreProtocol!

    private var stateHandlers: [ListenerProtocol]?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        store = RevolutTest.Store(
            state: AppState.initial,
            reducers: [RevolutTest.CurrenciesReducer,
                       RevolutTest.TimerReducer,
                       RevolutTest.NetworkReducer,
                       RevolutTest.EditingReducer],
            middlewares: [TimerToNetworkToUILogMiddleware()])

        let viewController = ListCurrenciesViewController()
        let tableViewAdapter = TableViewAdapter()

        viewController.tableViewAdapter = tableViewAdapter

        self.stateHandlers = [makeNetworkStateHandler(),
                              makeTableViewStateHandler(tableViewController: viewController, tableViewAdapter: tableViewAdapter),
                              makeTimerStateHandler()]


        let navigationController = UINavigationController(
            rootViewController: viewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {

    func makeTimerStateHandler() -> TimerStateHandler {

        return TimerStateHandler(
            store: store,
            interval: 10,
            repeats: true, timerFactory: TimerFactory())
    }

    func makeNetworkStateHandler() -> NetworkStateHandler {

        return NetworkStateHandler(
            store: store,
            fetcher: CurrenciesFetcher())
    }

    func makeTableViewStateHandler(
        tableViewController: UITableViewController,
        tableViewAdapter: TableViewAdapterProtocol) -> TableViewStateHandler {

        return TableViewStateHandler(
            store: store,
            tableViewController: tableViewController,
            adapter: tableViewAdapter)
    }
}

