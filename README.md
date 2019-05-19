Installation: Just clone the repo and run `pod install`

Only Kingfisher is the only pod lib used to handle images

I did not use Rx in the project neither did I use R.swift
Application is 100% built programmatically
Reduced boilerplate code as much as possible with tags where appropriate.

This application is built with the assumption that there are only 5 custom element types
```
    enum CustomElementType: String {
        case text
        case embeddedphoto
        case formattednumeric
        case datetime
        case yesno
    }
```

This is carefully outlined in the ~Extras/Types+Protocol~ folder

Have a wonderful day. Cheers
Adie Olalekan
