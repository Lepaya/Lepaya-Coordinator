//
// CoordinatorSession.swift
// 
// Created by Alessio Sardella on 08/05/2019.
// Copyright 2019 Alessio Sardella. All rights reserved.
//

import Foundation

final public class CoordinatorSession {
    
    static let shared = CoordinatorSession()
    public var tabCoordinator: TabCoordinator?
    public var navCoordinator: NCCoordinator?
    
}
