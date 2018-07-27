# A Count Down Timer

### Build Issue
    if your ecountered "impl/primitive_list_notifier.hpp' file not found" error during building process
    please follow below steps in terminal 
  
    cd [project location]/timer
    pod cache clean Realm
    pod cache clean RealmSwift
    pod deintegrate || rm -rf Pods
    pod install
    rm -rf ~/Library/Developer/Xcode/DerivedData

### Tech stack
1. CocoaPods - package manager 
2. Realm DB - for persisting task data
3. Basic MVC Architecture provided by Apple + Delegation + Protocol Programming
4. Programmtic AutoLayout without using any Xib / Storyboard
