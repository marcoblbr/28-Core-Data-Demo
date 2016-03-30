//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Marco Linhares on 8/1/15.
//  Copyright (c) 2015 Marco. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setando contexto para poder trabalhar com a base de dados
        var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
//        // criando um usuário a ser adicionado na base de dados
//        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! NSManagedObject
//        
//        newUser.setValue("Joao", forKey: "username")
//        newUser.setValue("222", forKey: "password")
//        
//        // salva no bd
//        context.save(nil)
        
        // pega dados do bd para mostrar na tela
        var request = NSFetchRequest (entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        // coloca uma lei de formação no request para ser feita uma busca
        // mais específica. é um critério de pesquisa a mais adicionado
        request.predicate = NSPredicate (format: "username = %@", "Marco")
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results?.count > 0 {
            
            println (results)
            
            for element : AnyObject in results! {
                if let user = element.valueForKey ("username") as? String {

                    if user == "Marco" {
                        // altera o password do user Marco
                        element.setValue("xxxxx", forKey: "password")
                        
                        
                        // apagando dados da bd
                        //context.deleteObject(element as! NSManagedObject)
                        //println ("user has been deleted")
                    }
                }
                
                context.save (nil)
            }
        } else {
            println ("Nenhum resultado")
        }
        
        println (results)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

