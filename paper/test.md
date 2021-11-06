
```plantuml
@startuml

!pragma layout smetana

[*] --> Idle
Idle --> [*]
Idle : do nothing wait for issues

Idle -> Development : issue
Development -> Idle
Development -> [*] : resign

@enduml
```
