//
//  ViewController.swift
//  Design Patterns
//
//  Created by SAHIL AMRUT AGASHE on 23/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Thank you God for this learning opportunity!")
        NullObjectMain()
    }


}

// MARK: - Design Patterns
struct ThePatterns {
    
    enum Creational: String {
        case Builder
        case AbstractFactory
        case FactoryMethod
        case Prototype
        case Singleton
    }
    
    enum Structural: String {
        case Adapter
        case Bridge
        case Composite
        case Decorator
        case Facade
        case Flyweight
        case Proxy
    }
    
    enum Behavioral: String {
        case ChainOfResponsibility
        case Command
        case Interpreter
        case Iterator
        case Mediator
        case Memento
        case NullObject
        case Observer
        case State
        case Strategy
        case TemplateMethod
        case Visitor
    }
}
